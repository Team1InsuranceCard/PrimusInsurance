<%-- 
    Document   : new-contract
    Created on : Jan 21, 2022, 9:39:11 PM
    Author     : quynm
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>InsuranceCard</title>
        <link rel="icon" href="asset/image/favicon.png" type="image/png" sizes="16x16">
        <!-- CDN to reset CSS -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.min.css" />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous"/>
        <link href="../../asset/style/customer/new_contract.css" rel="stylesheet" type="text/css"/>
        <base href="${pageContext.servletContext.contextPath}/">
    </head>
    <body>
        <c:set var="account" value="${sessionScope.account}"></c:set>
        <jsp:include page="../header_customer.jsp"></jsp:include>
            <div class="container">
                <h2 class="title">REQUEST NEW CONTRACT</h2>
                <form method="POST" action="">
                    <div class="content_container">
                        <div class="row">
                            <div class="col-lg-8 left">
                                <h3 class="group-title">1. OWNER'S INFORMATION</h3>
                            <c:if test="${sessionScope.account ne null}">
                                <div class="quick-checkbox">
                                    <input id="chk-1" type="checkbox" 
                                           onchange="fillOwnerInfo('${requestScope.customer.firstName}',
                                                           '${requestScope.customer.lastName}',
                                                           '${requestScope.customer.personalID}')"/>
                                    <label for="chk-1">Use your account's information</label>
                                </div>
                            </c:if>
                            <label for="txt1" class="label-input">Full name (*):</label>
                            <input id="txt1" class="inputdata" type="text" required
                                   name="ownerName" onchange="fillRightOwner()"
                                   placeholder="Owner full name (in vehicle registration)"/><br/>
                            <label for="txt2" class="label-input">ID Number (*):</label>
                            <input id="txt2" class="inputdata" type="text" required
                                   name="ownerID"
                                   placeholder="ID Card Number"/><br/>
                            <h3 class="group-title">2. VEHICLE'S INFORMATION</h3>
                            <label for="select1" class="label-input">Type (*):</label>
                            <select id="select1" class="selectdata" name="vehicleType">
                                <c:forEach items="${requestScope.vehicletypes}" var="type">
                                    <option>${type.vehicleType}</option>
                                </c:forEach>
                            </select><br/>
                            <label for="select3" class="label-input">Brand (*):</label>
                            <select id="select3" class="selectdata" name="brand">
                                <c:forEach items="${requestScope.brands}" var="brand">
                                    <option>${brand.brand}</option>
                                </c:forEach>
                            </select><br/>
                            <label for="txt3" class="label-input">License plate (*):</label>
                            <input id="txt3" class="inputdata" type="text" required
                                   name="licensePlate"
                                   onchange="fillRightLicensePlate()"
                                   placeholder="License plate (in vehicle registration)"/><br/>
                            <label for="txt9" class="label-input">Chassis number:</label>
                            <input id="txt9" class="inputdata" type="text"
                                   name="chassis"
                                   placeholder="Chassis number (in vehicle registration)"/><br/>
                            <label for="txt10" class="label-input">Engine number:</label>
                            <input id="txt10" class="inputdata" type="text" 
                                   name="engine"
                                   placeholder="Engine number (in vehicle registration)"/><br/>
                            <h3 class="group-title">3. INSURANCE SERVICE INFORMATION</h3>
                            <div class="row-input">
                                <span class="row-input1">
                                    <label for="txt4" class="label-input">Product (*):</label>
                                    <input id="txt4" class="inputdata" type="text" disabled="true"
                                           value="${requestScope.product.title}"/>
                                    <input type="hidden" name="product"
                                           value="${requestScope.product}"
                                </span>
                                <a href="customer/dashboard" class="btnProduct">Change product</a>
                            </div>
                            <label for="select2" class="label-input">Type (*):</label>
                            <select id="select2" class="selectdata" onchange="fillEndDate()">
                                <option value="1">1 year</option>
                                <option value="2">2 years</option>
                                <option value="3">3 years</option>
                            </select><br/>
                            <div class="row-input">
                                <span class=  "row-input1">
                                    <label for="startdate" class="label-input">Start date (*):</label>
                                    <input id="startdate" class="startdate" type="date"
                                           name="startDate"
                                           onchange="fillEndDate()" required
                                           value="${requestScope.now}"/>
                                </span>
                                <span class="row-input2">
                                    <label for="enddate" class="label-input">End date:</label>
                                    <input id="enddate" class="enddate" type="date" disabled="true"/>
                                    <input type="hidden" name="endDate" id="endDateSent"/>
                                </span>
                            </div>
                            <h3 class="group-title">4. DELIVERY INFORMATION</h3>
                            <c:if test="${sessionScope.account ne null}">
                                <div class="quick-checkbox">
                                    <input id="chk-2" type="checkbox" 
                                           onchange="fillDeliveryInfo('${requestScope.customer.firstName}',
                                                           '${requestScope.customer.lastName}',
                                                           '${requestScope.customer.phone}',
                                                           '${requestScope.customer.account.email}',
                                                           '${requestScope.customer.address}',
                                                           '${requestScope.customer.province}',
                                                           '${requestScope.customer.district}')"/>
                                    <label for="chk-2">Use your account's information</label>
                                </div>
                            </c:if>
                            <label for="txt5" class="label-input">Full name (*):</label>
                            <input id="txt5" class="inputdata" type="text" required
                                   name="deliveryName"
                                   placeholder="Full name of recipient"/><br/>
                            <label for="txt6" class="label-input">Phone number (*):</label>
                            <input id="txt6" class="inputdata" type="text" required
                                   name="deliveryPhone"
                                   placeholder="Phone number"/><br/>
                            <label for="txt7" class="label-input">Email (*):</label>
                            <input id="txt7" class="inputdata" type="text" required
                                   name="deliveryEmail"
                                   placeholder="Email"/><br/>
                            <label for="txt8" class="label-input">Address (*):</label>
                            <span class="address-container">
                                <input id="txt8" class="inputdata" type="text" 
                                       name="deliveryAddress"
                                       placeholder="Address" required/><br/>
                                <div class="select-container">
                                    <span class="province-container">
                                        <select id="province" name="calc_shipping_provinces" required>
                                            <option hidden>--Choose the province--</option>
                                        </select>
                                        <input class="billing_address_1" name="province" 
                                               type="hidden" value=""/>
                                    </span>
                                    <span class="district-container">
                                        <select id="district" name="calc_shipping_district" required>
                                            <option hidden>--Choose the district--</option>
                                        </select>
                                        <input class="billing_address_2" name="district" 
                                               type="hidden" value=""/>
                                    </span>
                                </div>
                            </span>

                            <div class="confirm-checkbox">
                                <input id="chk-3" type="checkbox" required
                                       onchange="enableCheckout()"/>
                                <label for="chk-3" class="label-confirm">
                                    I/we certify that the foregoing information is 
                                    complete and correct to the best of my/our 
                                    knowledge and agree that the foregoing 
                                    declarations form the basis of the insurance 
                                    policy and accept receive the insurance 
                                    conditions specified in the insurance contract.
                                </label>
                            </div>
                        </div>
                        <div class="col-lg-4 right">
                            <h3 class="group-title">PAYMENT INFORMATION</h3>
                            <div class="content">
                                <p>
                                    <b>Product:</b> <span>${requestScope.product.title}</span>
                                </p>
                                <p>
                                    <b>Insurance period: </b> <span id="period"></span>
                                </p>
                                <p>
                                    <b>Vehicle owner: </b> <span id="owner"></span>
                                </p>
                                <p>
                                    <b>License plate: </b> <span id="license-plate"></span>
                                </p>
                                <hr/>
                                <p>
                                    <b>Insurance fees: </b> 
                                    <span>VND <fmt:formatNumber pattern="#,###.##" 
                                                      value="${requestScope.product.price}">
                                        </fmt:formatNumber>
                                    </span>
                                </p>
                                <p>
                                    <b>Service charge: </b> <span>VND 0</span>
                                </p>
                                <hr/>
                                <p>                                    
                                    <b>TOTAL PAYMENT: 
                                        VND <fmt:formatNumber pattern="#,###.##" 
                                                          value="${requestScope.product.price}">
                                        </fmt:formatNumber></b>
                                </p>
                                <input type="submit" id="btnCheckout" 
                                       class="btnCheckout btnDisable"
                                       value="CHECK OUT" disabled/>
                                <!--<a href="#" id="btnCheckout" class="btnCheckout btnDisable">CHECK OUT</a>-->
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
        <jsp:include page="../footer_full.jsp"></jsp:include>


        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src='https://cdn.jsdelivr.net/gh/vietblogdao/js/districts.min.js'></script>
        <script src="http://code.jquery.com/ui/1.9.2/jquery-ui.js"></script> 
        <script src="asset/script/customer/new_contract.js"></script>
    </body>
</html>
