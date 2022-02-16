/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var searchBox = document.querySelector("#search-box");
var rootURL = new URL(window.location.href);

var customerFilter = document.querySelector("#customer-filter");
var startDateFilter = document.querySelector("#start-date-filter");
var endDateFilter = document.querySelector("#end-date-filter");
var contractInclude = document.querySelector("#contract-include");

var nameOrder = customerFilter.title;
var startOrder = startDateFilter.title;
var endOrder = endDateFilter.title;
var status = "";

// function createForm() {
//   var filterForm = document.createElement("form");
//   filterForm.setAttribute("id", "filter-form");
//   filterForm.setAttribute("method", "get");
//   filterForm.setAttribute("action", rootURL);

//   var customer = document.createElement("input");
//   customer.setAttribute("type", "hidden");
//   customer.setAttribute("name", "nameorder");
//   customer.setAttribute("value", );
// }

customerFilter.addEventListener("click", () => {
  setOrder(customerFilter, nameOrder, rootURL, "nameorder");
  window.location.href = rootURL;
});
startDateFilter.addEventListener("click", () => {
  setOrder(startDateFilter, startOrder, rootURL, "startorder");
  window.location.href = rootURL;
});
endDateFilter.addEventListener("click", () => {
  setOrder(endDateFilter, endOrder, rootURL, "endorder");
  window.location.href = rootURL;
});

var statusFilter = document.querySelector("#status-filter");
statusFilter.addEventListener("change", () => {
  var status = statusFilter.value;
  rootURL.searchParams.set("status", status);
  window.location.href = rootURL;
});

function toggleOrder(order) {
  if (order === "DESC") {
    order = "ASC";
  } else {
    order = "DESC";
  }
  return order;
}

function setOrder(domElement, order, URL, paramName) {
  var orderAfter = toggleOrder(order);
  domElement.title = orderAfter;
  URL.searchParams.set(paramName, orderAfter);
}
contractInclude.addEventListener("click", () => {
  rootURL.searchParams.set("contract", toggleInclueContract(contractInclude));
  window.location.href = rootURL;
});

if (contractInclude.ariaLabel === "all") {
  contractInclude.innerHTML = "Contract By All";
  contractInclude.title = "Click to toggle to Contract By Me";
} else {
  contractInclude.innerHTML = "Contract By Me";
  contractInclude.title = "Click to toggle to Contract By All";
}
function toggleInclueContract(contractInclude) {
  var param = "all";
  if (contractInclude.ariaLabel === "all") {
    param = "justme";
  } else {
    param = "all";
  }
  return param;
}

function createPager(domElementID, pageIndex, totalPage, rootURL) {
  const GAP = 1;
  var URLObject = new URL(rootURL);
  var container = document.querySelector("#" + domElementID);
  if (pageIndex > 1) {
    URLObject.searchParams.set("page", 1);
    container.innerHTML += `<li class="page-item ">
                                <a class="page-link" href="${URLObject}" tabindex="-1">First</a>
                            </li>`;
    URLObject.searchParams.set("page", pageIndex - 1);
    container.innerHTML += `<li class="page-item">
                                <a class="page-link" href="${URLObject}">&laquo;</a>
                            </li>`;
  }

  for (i = pageIndex - GAP; i < pageIndex; i++) {
    if (i > 0) {
      URLObject.searchParams.set("page", i);
      container.innerHTML += `<li class="page-item">
                                    <a class="page-link" href="${URLObject}">${i}</a>
                                </li>`;
    }
  }
  container.innerHTML += `
    <li class="page-item">
      <a class="page-link active">
        ${pageIndex}
      </a>
    </li>`;
  for (let i = pageIndex + 1; i <= pageIndex + GAP; i++) {
    if (i <= totalPage) {
      URLObject.searchParams.set("page", i);
      container.innerHTML += `<li class="page-item">
                                    <a class="page-link" href="${URLObject}">${i}</a>
                                </li>`;
    }
  }
  if (pageIndex < totalPage) {
    URLObject.searchParams.set("page", pageIndex + 1);
    container.innerHTML += `<li class="page-item"><a class="page-link" href="${URLObject}">&raquo;</a></li>`;
    URLObject.searchParams.set("page", totalPage);
    container.innerHTML += ` <li class="page-item item-last">
                                <a class="page-link" href="${URLObject}">Last</a>
                            </li>`;
  }
  //   if (pageIndex > 1) {
  //     container.innerHTML += `<a href="${requestPath}&page=${
  //       pageIndex - 1
  //     }">&laquo;</a>`;
  //   }
  //   if (pageIndex - GAP > 1) {
  //     container.innerHTML += `<a href="${requestPath}&page=1">1</a>`;
  //     container.innerHTML += `<a onclick="goToPage('${requestPath}')">...</a>`;
  //   }
  //   for (let i = pageIndex - GAP; i < pageIndex; i++) {
  //     if (i > 0) {
  //       container.innerHTML += `<a href="${requestPath}&page=${i}">${i}</a>`;
  //     }
  //   }
  //   container.innerHTML += `<a  class="active">${pageIndex}</a>`;
  //   for (let i = pageIndex + 1; i <= pageIndex + GAP; i++) {
  //     if (i <= totalPage) {
  //       container.innerHTML += `<a href="${requestPath}&page=${i}">${i}</a>`;
  //     }
  //   }
  //   if (pageIndex + GAP < totalPage) {
  //     container.innerHTML += `<a onclick="goToPage('${requestPath}')">...</a>`;
  //     container.innerHTML += `<a href="${requestPath}&page=${totalPage}">${totalPage}</a>`;
  //   }

  //   if (pageIndex < totalPage) {
  //     container.innerHTML += `<a href="${requestPath}&page=${
  //       pageIndex + 1
  //     }">&raquo;</a>`;
  //   }
}
