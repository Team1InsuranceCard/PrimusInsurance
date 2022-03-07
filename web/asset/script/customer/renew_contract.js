
function fillEndDate() {
    var start = document.getElementById("startDate").value;
    var duration = document.getElementById("duration").value;

    if (start != "" && duration != 0) {
        var startDate = new Date(start.toString());
        if (duration == 1) {
            startDate.setDate(startDate.getDate() + (365 * 1));
        } else if (duration == 2) {
            startDate.setDate(startDate.getDate() + (365 * 2));
        } else if (duration == 3) {
            startDate.setDate(startDate.getDate() + (365 * 3));
        }

        var date = startDate.getDate();
        var month = startDate.getMonth() + 1;

        if (date / 10 < 1) {
            date = "0" + date.toString();
        }

        if (month / 10 < 1) {
            month = "0" + month.toString();
        }

        var end = date + "/" + month + "/" + startDate.getFullYear();
        document.getElementById("endDate").innerHTML = end;
    }
}

function renew() {
    var startDate = document.getElementById("startDate").value;
    var duration = document.getElementById("duration").value;

    if (startDate == "" || duration == 0) {
        Swal.fire({
            position: 'top',
            text: "Fill Duration and Start date!",
            icon: 'error',
            showCancelButton: true,
            cancelButtonColor: '#1F74B6',
            cancelButtonText: 'OK',
            showConfirmButton: false
        })
    } else {
        var price = document.getElementById("price").value;
        var fee = duration * price.valueOf();
        Swal.fire({
            position: 'top',
            title: 'Are you sure?',
            text: "Total: " + fee.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + " VND",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes'
        }).then((result) => {
            if (result.isConfirmed) {
                var renew = "renew";
                sessionStorage.setItem("renew", renew);
                document.getElementById("myForm").submit();
            }
        })
    }
}


