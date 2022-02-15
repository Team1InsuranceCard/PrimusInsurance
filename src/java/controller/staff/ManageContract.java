/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.staff;

import controller.externalmodule.PaginationModule;
import dao.ContractDBContext;
import dao.StatusCodeDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Account;
import model.Contract;
import model.ContractStatusCode;

/**
 *
 * @author area1
 */
public class ManageContract extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Manage_contract</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Manage_contract at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

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

        HttpSession session = request.getSession();
        Account currentStaffAccount = (Account) session.getAttribute("account");
        int staffAccountID = currentStaffAccount.getId();
//        int staffAccountID = 7;
        String query = request.getParameter("query");
        String customerNameOrdered = request.getParameter("nameorder");
        String startDateOrdered = request.getParameter("startorder");
        String endDateOrdered = request.getParameter("endorder");
        String contractStatusCode = request.getParameter("status");
        String rawpageIndex = request.getParameter("page");
        rawpageIndex = (rawpageIndex == null || rawpageIndex.isEmpty()) ? "1" : rawpageIndex;
        int pageIndex = Integer.parseInt(rawpageIndex);

        StatusCodeDBContext statusDBC = new StatusCodeDBContext();
        ArrayList<ContractStatusCode> statusCodes = statusDBC.getContractStatusCodes();
        
        String stringAllStatus = "0";
        for (ContractStatusCode statusCode : statusCodes) {
            stringAllStatus += "," + statusCode.getStatusCode();
        }
        
        contractStatusCode = (contractStatusCode == null || contractStatusCode.isEmpty()) ? stringAllStatus : contractStatusCode;

        ContractDBContext contractDBC = new ContractDBContext();
        HashMap<Integer, Contract> contractList = contractDBC.getContractsByStaff(staffAccountID, query, pageIndex,
                customerNameOrdered, startDateOrdered, endDateOrdered, contractStatusCode);
        int totalRecord = contractDBC.totalContractsByStaff(staffAccountID, query, contractStatusCode);
        int totalPage = PaginationModule.calcTotalPage(totalRecord, 20);
        request.setAttribute("contract_list", contractList);
        request.setAttribute("status_codes", statusCodes);
        request.setAttribute("query", query);
        request.setAttribute("nameorder", customerNameOrdered);
        request.setAttribute("startorder", startDateOrdered);
        request.setAttribute("endorder", endDateOrdered);
        request.setAttribute("status", contractStatusCode);
        request.setAttribute("totalpage", totalPage);
        request.setAttribute("page", pageIndex);

//        response.sendRedirect("../view/staff/manage_contract.jsp");
        request.getRequestDispatcher("../../view/staff/manage_contract.jsp").forward(request, response);
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
