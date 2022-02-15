<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@page
contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Insurance Card</title>
    <base href="${pageContext.servletContext.contextPath}/" />
    <link
      rel="icon"
      href="asset/image/favicon.png"
      type="image/png"
      sizes="16x16"
    />
    <link rel="stylesheet" href="asset/style/staff/view_contract.css" />
  </head>
  <body>
    <jsp:include page="../header_staff.jsp">
      <jsp:param name="currentscreen" value="customer" />
    </jsp:include>

    <main>
      <div class="header">
        <h1 class="header__heading">Contract</h1>
        <div class="header__btn">
          <a class="btn btn--primary" href="">
            <img class="btn__icon" src="asset/image/staff/view_contract/icon_reload.png"></img>
            <div class="btn__text">Renew</div>
          </a>

          <a class="btn btn--danger" href="">
            <img class="btn__icon" src="asset/image/staff/view_contract/icon_close.png"></img>
            <div class="btn__text">Cancel</div>
          </a>
        </div>
      </div>

      <div class="section">
        <h2 class="section__heading">General Information</h2>
        <div class="section__main">
          <div class="section__item">
            <div class="section__title">Contract ID</div>
            <div class="section__text">HD0001</div>
          </div>

          <div class="section__item">
            <div class="section__title">Status</div>
            <div class="section__text">Active</div>
          </div>

          <div class="section__item">
            <div class="section__title">Product</div>
            <div class="section__text">Product title</div>
          </div>

          <div class="section__item">
            <div class="section__title">Start Date</div>
            <div class="section__text">25/7/2021</div>
          </div>
        </div>
      </div>

      <div class="section">
        <h2 class="section__heading">Customer Information</h2>
        <div class="section__main">
          <div class="section__item">
            <div class="section__title">Name</div>
            <div class="section__text">Trần Khánh Huyền</div>
          </div>

          <div class="section__item">
            <div class="section__title">Email</div>
            <div class="section__text">huyentk@gmail.com</div>
          </div>

          <div class="section__item">
            <div class="section__title">Date of Birth</div>
            <div class="section__text">25/8/2001</div>
          </div>

          <div class="section__item">
            <div class="section__title">Personal ID</div>
            <div class="section__text">025458995</div>
          </div>

          <div class="section__item">
            <div class="section__title">Phone</div>
            <div class="section__text">0265985456</div>
          </div>

          <div class="section__item">
            <div class="section__title">Address</div>
            <div class="section__text">268A đường 20/8</div>
          </div>
        </div>
      </div>

      <div class="section">
        <h2 class="section__heading">Vehicle Information</h2>
        <div class="section__main">
          <div class="section__left">
            <div class="section__item">
              <div class="section__title">Vehicle type</div>
              <div class="section__text">Sport</div>
            </div>
  
            <div class="section__item">
              <div class="section__title">Engine</div>
              <div class="section__text">dfsd</div>
            </div>
  
            <div class="section__item">
              <div class="section__title">License Plate</div>
              <div class="section__text">gfdgf</div>
            </div>
  
            <div class="section__item">
              <div class="section__title">Color</div>
              <div class="section__text">dfsd</div>
            </div>
  
            <div class="section__item">
              <div class="section__title">Brand</div>
              <div class="section__text">fsfgf</div>
            </div>
  
            <div class="section__item">
              <div class="section__title">Owner</div>
              <div class="section__text">dsfsf</div>
            </div>
  
            <div class="section__item">
              <div class="section__title">Chassis</div>
              <div class="section__text">fwefe</div>
            </div>
          </div>
          
          <div class="section__right">
            <div class="section__item">
              <div class="section__title">Cert Image</div>
              <img class="section__img" src="https://tincongnghe24h.net/wp-content/uploads/2021/02/giai-nen-file-img.jpg"></img>
            </div>
          </div>          
        </div>
      </div>

      <div class="section">
        <h2 class="section__heading">Product Information</h2>
        <div class="section__main">
          <div class="section__item">
            <div class="section__title">Product ID</div>
            <div class="section__text">sfs</div>
          </div>

          <div class="section__item">
            <div class="section__title">Product Title</div>
            <div class="section__text">sfs</div>
          </div>

          <div class="section__item">
            <div class="section__title">Content detail</div>
            <div class="section__text">sfs</div>
          </div>
        </div>
      </div>
    </main>

    <jsp:include page="../footer_full.jsp">
      <jsp:param name="currentscreen" value="customer" />
    </jsp:include>
  </body>
</html>
