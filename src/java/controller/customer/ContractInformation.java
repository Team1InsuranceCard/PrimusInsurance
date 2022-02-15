/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.customer;

import dao.ContractDBContext;
import dao.ProductDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Account;
import model.Contract;

/**
 *
 * @author ASUS
 */
public class ContractInformation extends HttpServlet {

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
        request.setCharacterEncoding("UTF-8");
        int contractID = Integer.parseInt(request.getParameter("id"));

        Account acc = (Account) request.getSession().getAttribute("account");
        ContractDBContext cdb = new ContractDBContext();
        Contract contract = cdb.getContractDetailByCustomer(3, contractID); //change to acc.id

        ProductDBContext pdb = new ProductDBContext();
        short proID = pdb.checkStatus(contract.getProduct().getId());

        boolean checkRenewRight = cdb.checkRenewRight(3, contract.getProduct().getId(), contractID); //change to acc.id

        String btn = "";
        if (contract.getStatus() == 3) {
            btn += "Undo";
        } else if (contract.getStatus() == 1 || contract.getStatus() == 2) {
            btn += "Cancel";
        } else { //status = 0,4
            btn += "Renew";
        }

        Date date1 = null;
        Date date2 = null;
        long getDaysDiff = 0;

        try {
            DateFormat simpleDateFormat = new SimpleDateFormat("dd-MM-yyyy");
            String startDate = simpleDateFormat.format(contract.getStartDate());
            String endDate = simpleDateFormat.format(contract.getEndDate());

            date1 = (Date) simpleDateFormat.parse(startDate);
            date2 = (Date) simpleDateFormat.parse(endDate);

            long getDiff = date2.getTime() - date1.getTime();

            getDaysDiff = getDiff / (24 * 60 * 60 * 1000) / 365;

        } catch (ParseException e) {
        }

        request.setAttribute("contract", contract);
        request.setAttribute("btn", btn);
        request.setAttribute("pro", proID);
        request.setAttribute("mess", proID == 0 ? "Product is inactive!" : "");
        request.setAttribute("contractID", contractID);
        request.setAttribute("duration", getDaysDiff);
        request.setAttribute("checkRenew", checkRenewRight == true
                ? "" : "Can't renew because contract was renewed or is being processed!");
        request.getRequestDispatcher("../../view/customer/contract_information.jsp").forward(request, response);
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
        request.setCharacterEncoding("UTF-8");
        String btn = request.getParameter("btn");
        int contractID = Integer.parseInt(request.getParameter("id"));

        if (btn.equals("Renew")) {
            request.getSession().setAttribute("contractID", contractID);
            response.sendRedirect("renew");
        } else if (btn.equals("Cancel")) {
            //Quý
            response.sendRedirect("cancel");
        } else if (btn.equals("Undo")) {
            ContractDBContext cdb = new ContractDBContext();
            cdb.undoCancelContractByCustomer(contractID);
            request.getSession().setAttribute("undo", "Undo successfully!");
            response.sendRedirect("detail?id=" + contractID);
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
