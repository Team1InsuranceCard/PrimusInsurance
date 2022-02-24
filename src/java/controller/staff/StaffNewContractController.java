/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.staff;

import dao.AccountDBContext;
import dao.BrandDBContext;
import dao.ContractDBContext;
import dao.CustomerDBContext;
import dao.ProductDBContext;
import dao.StaffDBContext;
import dao.StatusCodeDBContext;
import dao.VehicleTypeDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Account;
import model.Brand;
import model.Contract;
import model.ContractStatusCode;
import model.Customer;
import model.Product;
import model.Staff;
import model.VehicleType;

/**
 *
 * @author quynm
 */
public class StaffNewContractController extends HttpServlet {

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
        response.setCharacterEncoding("UTF-8");

        ProductDBContext pdb = new ProductDBContext();

        String productID = request.getParameter("productID");
        int pID;
        if (productID != null) {
            try {
                pID = Integer.parseInt(productID);
            } catch (NumberFormatException ex) {
                //incorrect product id => set pid to 0
                pID = 0;
            }
        } else {
            pID = 0;
        }
        //get Product sent by URL if there is
        Product product = pdb.getProductByID(pID);
        request.setAttribute("productSent", product);
        
        //get current date
        LocalDate d = LocalDate.now();
        request.setAttribute("now", d);

        //get vehicle types
        VehicleTypeDBContext vtdb = new VehicleTypeDBContext();
        ArrayList<VehicleType> vehicleTypes = vtdb.getVehicleTypes();
        request.setAttribute("vehicletypes", vehicleTypes);

        //get brands
        BrandDBContext bdb = new BrandDBContext();
        ArrayList<Brand> brands = bdb.getBrands();
        request.setAttribute("brands", brands);

        //get all products
        ArrayList<Product> products = pdb.getProducts();
        request.setAttribute("products", products);

        request.getRequestDispatcher("../../view/staff/new-contract.jsp")
                .forward(request, response);

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
        response.setCharacterEncoding("UTF-8");

        VehicleTypeDBContext vtdb = new VehicleTypeDBContext();
        BrandDBContext bdb = new BrandDBContext();
        ProductDBContext pdb = new ProductDBContext();
        CustomerDBContext cdb = new CustomerDBContext();
        StatusCodeDBContext scdb = new StatusCodeDBContext();
        StaffDBContext sdb = new StaffDBContext();
        ContractDBContext ctdb = new ContractDBContext();
        AccountDBContext adb = new AccountDBContext();

        String ownerName = request.getParameter("ownerName");
        String cusID = request.getParameter("customerID");
        String vehicleTypeID = request.getParameter("vehicleTypeID");
        String brandID = request.getParameter("brandID");
        String licensePlate = request.getParameter("licensePlate");
        String chassis = request.getParameter("chassis");
        String engine = request.getParameter("engine");
        String productID = request.getParameter("productID");
        String start = request.getParameter("startDate");
        String end = request.getParameter("endDate");
        String deliveryName = request.getParameter("deliveryName");
        String deliveryPhone = request.getParameter("deliveryPhone");
        String deliveryEmail = request.getParameter("deliveryEmail");
        String deliveryAddress = request.getParameter("deliveryAddress");
        String deliveryProvince = request.getParameter("province");
        String deliveryDistrict = request.getParameter("district");
        String fee = request.getParameter("fee");
        //get current staff
        Account staffAccount = (Account) request.getSession().getAttribute("account");
        Staff startStaff = null;
        if (staffAccount != null) {
            //get staff by account if user logged in (account has been saved in session)
            startStaff = sdb.getStaff(staffAccount.getId());
        }
        //getCustomer
        Customer customer = null;
        try {
            int cid = Integer.parseInt("cusID");
            Account cusAccount = adb.getAccount(cid);
            customer = cdb.getCustomerByAccount(cusAccount);
        } catch (Exception e) {
            
        }

        VehicleType type = vtdb.getVehicleTypeByID(Integer.parseInt(vehicleTypeID));
        Brand brand = bdb.getBrandByID(Integer.parseInt(brandID));
        Product product = pdb.getProduct(Integer.parseInt(productID));
        Timestamp startDate = Timestamp.valueOf(start + " 00:00:00");
        Timestamp endDate = Timestamp.valueOf(end + " 23:59:59");
        //set default status to pending - code:2
        ContractStatusCode status = scdb.getContractStatusCode(2);
        Timestamp requestDate = Timestamp.valueOf(LocalDateTime.now());
        Double contractFee = Double.parseDouble(fee);

        Contract contract = new Contract();
        contract.setOwner(ownerName);
        contract.setVehicleType2(type);
        contract.setBrand2(brand);
        contract.setLicensePlate(licensePlate);
        contract.setChassis(chassis);
        contract.setEngine(engine);
        contract.setProduct(product);
        contract.setStartDate(startDate);
        contract.setEndDate(endDate);
        contract.setCustomer(customer);
        contract.setStatusCode(status); //pending
        contract.setRequestDate(requestDate);
        contract.setContractFee(contractFee);
        contract.setStartStaff(startStaff);
        
        //save delivery info to delivery table (not yet)
        
        
        //insert to DB
        contract.setId(ctdb.insertContract(contract));
        
        //redirect to view contract detail page
        request.getRequestDispatcher("/staff/contract/detail?id="+contract.getId())
                .forward(request, response);
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
