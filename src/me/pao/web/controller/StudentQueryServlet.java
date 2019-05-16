package me.pao.web.controller;
import javax.servlet.http.HttpServlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import me.pao.domain.Record;
import me.pao.domain.User;
import me.pao.service.IUserService;
import me.pao.service.impl.UserServiceImpl;

import java.io.IOException;
import java.util.List;

public class StudentQueryServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userName = request.getParameter("studentName");
        String userId = ((User)request.getSession().getAttribute("user")).getId();
        String y = request.getParameter("year");
        String m = null;
        if(!request.getParameter("month").equals("33")){
            m = String.format("%02d", Integer.parseInt(request.getParameter("month")));
        }
        String d = null;
        System.out.println(request.getParameter("day"));
        if(!request.getParameter("day").equals("33")){
            d = String.format("%02d", Integer.parseInt(request.getParameter("day")));
        }
        IUserService service = new UserServiceImpl();
        List<Record> li= null;
        if(userName==null)
            li=service.findRecord(userId,y,m,d);
        else
            li = service.findRecordByName(userName,y,m,d);
        request.setAttribute("record",li);
        request.getRequestDispatcher("/index/index.jsp").forward(request, response);
    }
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
