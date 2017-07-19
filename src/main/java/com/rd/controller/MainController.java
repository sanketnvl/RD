package com.rd.controller;

import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.log4j.Logger;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageTree;
import org.apache.pdfbox.pdmodel.common.PDRectangle;
import org.apache.pdfbox.rendering.PDFRenderer;
import org.apache.pdfbox.tools.imageio.ImageIOUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.rd.model.File;
import com.rd.model.FileValidator;
import com.rd.model.Pixel;

@Controller
@RequestMapping("/")
public class MainController {

	private static final Logger logger = Logger.getLogger(MainController.class);

	@Autowired
	FileValidator validator;

	@InitBinder
	private void initBinder(WebDataBinder binder) {
		binder.setValidator(validator);
	}

	@RequestMapping(method = RequestMethod.GET)
	public String getForm(Model model) {
		File fileModel = new File();
		model.addAttribute("file", fileModel);
		return "file";
	}

	@RequestMapping(value = "/fileupload", method = RequestMethod.POST)
	public ModelAndView fileUploaded(@Validated File file, BindingResult result) {
		Map<String, Object> model = new HashMap<String, Object>();
		String returnVal = "viewDocument";
		String uniqueFile = null;
		if (result.hasErrors()) {
			returnVal = "file";
		} else {
			MultipartFile multipartFile = file.getFile();
			try {
				byte[] bytes = multipartFile.getBytes();
				uniqueFile = RandomStringUtils.randomAlphanumeric(10) + ".pdf";
				Path path = Paths.get("D:/RD/upload/" + uniqueFile);
				Files.write(path, bytes);

			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		model.put("fileName", uniqueFile);
		return new ModelAndView(returnVal, model);
	}

	@RequestMapping(value = "/upload", method = RequestMethod.GET)
	public ModelAndView index() {
		logger.info("-------------------------Upload document----------------------");
		return new ModelAndView("upload");
	}

	public static Path writePDF(MultipartFile multipartFile) {
		String classMethod = "writePDF";
		logger.info(String.format("Enter into " + classMethod + "()"));
		Path path = null;
		try {
			path = Files.createTempFile(multipartFile.getName(), ".pdf");
			Files.write(path, multipartFile.getBytes());

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		logger.info("Temp file : " + path);
		logger.info(String.format("Exit into " + classMethod + "()"));
		return path;
	}

	@RequestMapping(value = "/img")
	public void img(@RequestParam("filename") String fname, @RequestParam("page") String fpage, RedirectAttributes attr,
			HttpServletResponse response) {
		java.io.File f = new java.io.File("D:/RD/upload/"+fname);
		try {
			if (f.exists()) {
				writeImageToBrowser(response, f, fpage);
			} else {
				// logger.error("File Not Found.");
				attr.addFlashAttribute("fileMsg", "File Not Found.");
			}

		} catch (Exception e) {
			// logger.error("Error while Reading file: "+e);
			attr.addFlashAttribute("fileMsg", e);
		} finally {

		}
	}

	public static Pixel getPageCount(java.io.File f) {
		PDDocument document = null;
		int count = 0;
		Pixel p = new Pixel();
		try {
			document = PDDocument.load(f);
			count = document.getNumberOfPages();
			PDPageTree allPages = document.getPages();
			PDPage page = (PDPage) allPages.get(count - 1);
			PDRectangle cropBox = page.getCropBox();
			System.out.println("CropBox width" + cropBox.getWidth() + "height" + cropBox.getHeight());
			System.out.println("Width " + page.getMediaBox().getWidth());
			System.out.println("Height " + page.getMediaBox().getHeight());
			p.setPageCount(count);
			p.setHeight(page.getMediaBox().getHeight() / 0.75f);
			p.setWidth(page.getMediaBox().getWidth() / 0.75f);
			document.close();
		} catch (IOException e) {
			logger.error("Error while getting page numbers: " + e);
			e.printStackTrace();
		} finally {
			// f.deleteOnExit();
			// f.delete();
		}

		return p;
	}

	public static void writeImageToBrowser(HttpServletResponse response, java.io.File f, String fpage) {

		try {

			PDDocument document = PDDocument.load(f);
			PDFRenderer pdfRenderer = new PDFRenderer(document);
			int pageCounter = Integer.parseInt(fpage) - 1;

			// note that the page number parameter is zero based
			BufferedImage bim = pdfRenderer.renderImageWithDPI(pageCounter, 80,
					org.apache.pdfbox.rendering.ImageType.RGB);

			response.setContentType("image/png");
			OutputStream out = response.getOutputStream();
			// suffix in filename will be used as the file format
			ImageIOUtil.writeImage(bim, "png", out, 80);

			document.close();
			response.flushBuffer();
			bim.flush();
			out.flush();
			out.close();

		} catch (IOException e) {
			logger.error("Error while reading pdf and converting to image: " + e);
			e.printStackTrace();
		} finally {
			// f.deleteOnExit();
		}
	}

	@RequestMapping(value = "/getViewDocument", method = RequestMethod.GET)
	public @ResponseBody void getDocument(
			@RequestParam(value = "fileName") String fileName, 
			HttpServletRequest request, HttpServletResponse response) throws IOException {
		java.io.File f = null;
		f = new java.io.File("D:/RD/upload/"+fileName);
		if (f.exists()) {
			Pixel p = getPageCount(f);
			Map<String, String> map = new HashMap<String, String>();
			map.put("numpages", "" + p.getPageCount());
			map.put("pwidth", String.valueOf(p.getWidth()));
			map.put("pheight", String.valueOf(p.getHeight()));
			map.put("filename", fileName);
			String json = new Gson().toJson(map);
			response.setContentType("application/json");
			response.getWriter().write(json);

		} else {
			String json = new Gson().toJson("failed");
			response.setContentType("application/json");
			response.getWriter().write(json);
		}
	}
}
