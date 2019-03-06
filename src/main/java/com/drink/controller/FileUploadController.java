/** 
* @ Title: FileUploadController.java 
* @ Package: com.drink.controller.file 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2017. 6. 20. 오후 1:49:39 
* @ Version V0.0 
*/ 
package com.drink.controller;

import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.geom.AffineTransform;
import java.awt.image.BufferedImage;
import java.io.File;
import java.util.List;
import java.util.Locale;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.swing.ImageIcon;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.core.io.FileSystemResource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import com.drink.dto.model.file.FileParam;

/** 
* @ ClassName: FileUploadController 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2017. 6. 20. 오후 1:49:39 
*  
*/

@Controller
public class FileUploadController {
	
	private static Logger logger = LogManager.getLogger(FileUploadController.class);
	
	@Autowired
	private MessageSource messageSource;
	
	@Autowired
	private FileSystemResource uploadDirResource;
	
	/** 
	* @ Title: fileUpload 
	* @ Description: 
	* @ Param: @return
	* @ Param: @throws Exception 
	* @ Return: String
	* @ Date: 2017. 6. 20. 오후 1:56:57
	* @ Throws 
	*
	*   <-- Modification Infomation -->
	*   수정일			수정자			수정내용
	*   ------			------			--------------------------------
	*
	*/ 
	@RequestMapping(value = "/fileUpload")
	public String fileUpload(Locale locale, Model model,  MultipartRequest multiPartRequest,  HttpServletRequest param )throws Exception {
		
		List<MultipartFile> multiPartFile = multiPartRequest.getFiles("files");
		for ( MultipartFile fileArg : multiPartFile) {
			logger.info("파일 이름 ::: " + fileArg.getName());
			logger.info("파일 이름 ::: " + fileArg.getOriginalFilename());
			logger.info("파일 크기 ::: " + fileArg.getSize());
			logger.info("컨텐트 타입 ::: " + fileArg.getContentType());
			
			File file = new File("D:/images/" + fileArg.getOriginalFilename());
			fileArg.transferTo(file);
		}
		
		logger.info("param1 :: " + param.getParameter("name") );
		
		
		return null;
	}
	
	@RequestMapping(value = "/fileUpload2")
	public String fileUpload2(Locale locale, Model model,   FileParam multiPartFile,  HttpServletRequest param )throws Exception {
		if(multiPartFile.getFiles() != null){
			for ( MultipartFile fileArg : multiPartFile.getFiles() ) {
				logger.info(fileArg.isEmpty());
				if(!fileArg.isEmpty()){
					logger.info("파일 이름 ::: " + fileArg.getName());
					logger.info("파일 이름 ::: " + fileArg.getOriginalFilename());
					logger.info("파일 크기 ::: " + fileArg.getSize());
					logger.info("컨텐트 타입 ::: " + fileArg.getContentType());
					logger.info("컨텐트 타입 ::: " +  fileArg);
					logger.info("uploadDirResource ::: " + uploadDirResource.getPath() + " :: " + uploadDirResource.getFilename());
					File file = new File("D:/images/" + fileArg.getOriginalFilename());
					fileArg.transferTo(file);
					/*BufferedImage bi2 = ImageIO.read( new File("D:/images/" + fileArg.getOriginalFilename()));
					logger.info("image size ::: " +  bi2.getWidth() + " height:: " + bi2.getHeight());
					ImageIcon ic = resizeImage("D:/images/" + fileArg.getOriginalFilename(), 250, 250);
					Image i = ic.getImage();
					BufferedImage bi = new BufferedImage(i.getWidth(null), i.getHeight(null), BufferedImage.TYPE_INT_RGB);
					Graphics2D g2 = bi.createGraphics();
					g2.drawImage(i, 0, 0, null);
					g2.dispose();
					String newFileName = fileArg.getOriginalFilename().replaceFirst(".jpg", "_resize.jpg");
					String newPath = "D:/images/"+newFileName;
					ImageIO.write(bi, "jpg", new File(newPath));
					System.out.println(newPath);*/
				}
			}
		}
		//servlet-context.xml -- org.springframework.core.io.FileSystemResource  셋팅 테스트 진행 
		logger.info("param1 :: " + param.getParameter("name") );
		
		
		return null;
	}
	
	public static ImageIcon resizeImage(String fileName, int maxWidth, int maxHeight){

		String data = fileName;

		BufferedImage src, dest;

		ImageIcon icon;

		

		try{

			src = ImageIO.read(new File(data));

			

			int width = src.getWidth();

			int height = src.getHeight();

			

			if(width > maxWidth){

				float widthRatio = maxWidth/(float)width;

				width = (int)(width*widthRatio);

				height = (int)(height*widthRatio);

			}

			if(height > maxHeight){

				float heightRatio = maxHeight/(float)height;

				width = (int)(width*heightRatio);

				height = (int)(height*heightRatio);

			}

			

			dest = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);

			Graphics2D g = dest.createGraphics();

			AffineTransform at = AffineTransform.getScaleInstance((double) width / src.getWidth(), (double)height / src.getHeight());

			g.drawRenderedImage(src, at);

			

			icon = new ImageIcon(dest);

			return icon;

		}catch(Exception e){

			 System.out.println("This image can not be resized. Please check the path and type of file.");

	         return null;

		}

	}


}
