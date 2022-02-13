/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.AccountDBContext;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Account;

/**
 *
 * @author ADMIN
 */
public class Login extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
//    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        response.setContentType("text/html;charset=UTF-8");
//        
//    }
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        processRequest(request, response);
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cooky : cookies) {
                if (cooky.getName().equals("userCookie")) {
                    request.setAttribute("username", cooky.getValue());
                }
                if (cooky.getName().equals("passCookie")) {
                    request.setAttribute("password", cooky.getValue());
                }
            }
        }
        Account acc = (Account) request.getSession().getAttribute("account");
        if (acc == null) {
            request.getRequestDispatcher("view/login.jsp").forward(request, response);
        } else if (!acc.isRole()) {
            request.getRequestDispatcher("view/customer/customer_dashboard.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("view/customer/staff_dashboard.jsp").forward(request, response);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //        processRequest(request, response);
        String username = request.getParameter("user");
        String password = request.getParameter("pass");
        String remember = request.getParameter("remember");

        AccountDBContext db = new AccountDBContext();
        Account account = db.getAccount(username, password);

        if (account != null) {
            request.getSession().setAttribute("account", account);
            Cookie cookieU = new Cookie("userCookie", username);
            Cookie cookieP = new Cookie("passCookie", username);
            cookieU.setMaxAge(60);
            if (remember != null) {
                cookieP.setMaxAge(60);
                request.getSession().setAttribute("remember", remember);
            } else {
                cookieP.setMaxAge(0);
            }

            response.addCookie(cookieU);
            response.addCookie(cookieP);

            if (account.isRole()) {
                response.sendRedirect("staff/dashboard");
            } else {
                response.sendRedirect("customer/dashboard");
            }
        } else {
            request.getSession().setAttribute("account", null);
            request.setAttribute("alert", "Your email or password is wrong. Try again!");
            request.getRequestDispatcher("view/login.jsp").forward(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
