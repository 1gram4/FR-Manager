package me.pao.web.controller;

import me.pao.domain.User;
import me.pao.service.IUserService;
import me.pao.service.impl.UserServiceImpl;
import me.pao.util.ClientUploadUtils;
import org.apache.commons.lang.StringUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
@MultipartConfig(location = "F:/temp/",maxFileSize = 1024*1024*10)
public class GetPartBody extends HttpServlet {
    //private int i = 0;
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        IUserService userService = new UserServiceImpl();
        int i = Integer.parseInt(req.getParameter("i"));
        req.setCharacterEncoding("UTF-8");
        Part part = req.getPart("file");
        //String filename = getFilename(part);
        //System.out.println(filename);
        String userId = ((User)req.getSession().getAttribute("user")).getId();
        String filename = userId+"_"+i+".png";
        writeTo(filename,part,userId);
        if(i == 200){
            userService.addImgPath(userId,"F:/userimg/"+userId);
            ((User) req.getSession().getAttribute("user")).setImgPath("F:/userimg/"+userId);
        }
        //上传照片到liu
        try {
            String fileName = userId+"_"+i+".png";
            String filePath = "F:\\userimg\\"+userId+"\\"+userId+"_"+i+".png";
            String url = "http://172.20.10.9:8012/";
            System.out.println(ClientUploadUtils.upload(url, filePath, fileName).string());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    private String getFilename(Part part){
        if(part==null)
            return null;
        String fileName = part.getHeader("content-disposition");
        System.out.println(fileName);
        if(StringUtils.isBlank(fileName)){
            return null;
        }
        return StringUtils.substringBetween(fileName,"filename=\"","\"");
    }
    private void writeTo(String fileName, Part part,String userId) throws FileNotFoundException, IOException {
        String path = "F:/userimg/"+userId;
        File filePath = new File(path);
        //判断该文件夹是否已存在
        if(!filePath.exists()){
            //不存在
            filePath.mkdirs();
        }
        part.write(path + File.separator + fileName);
        /***
         InputStream in = part.getInputStream();
         OutputStream out = new FileOutputStream("c:/workspace" + fileName);
         byte[] buffer = new byte[1024];
         int length = -1;
         while ((length = in.read(buffer)) != -1) {
         out.write(buffer, 0, length);
         }
         in.close();
         out.close();
         ***/
    }
}
