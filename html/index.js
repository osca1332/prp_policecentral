
var iden;


$(function () {


    function display(bool) {
        if (bool) {
            $(".tablet").show();
        } else {
            $(".tablet").hide();
        }
    }


    display(false)
    $(".t-info").hide();

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
            } else {
                display(false)
            }
        }

        if (item.type === "result") {
            var data = item.obj;
            iden = null;
            iden = data;
            document.getElementById("result").innerHTML =""
            for (var i = 0; i<data.length;i++) {
                var x = document.getElementById("result").insertRow(i);
                x.insertCell(0).innerHTML = data[i].name+", "+data[i].firstname;
                x.addEventListener("click", function(){
                    $(".identity").hide();
                    $(".t-info").show();
                    document.getElementById("t-navn").innerHTML = data[this.rowIndex].name+", "+data[this.rowIndex].firstname;
                    document.getElementById("t-age").innerHTML = data[this.rowIndex].age+" år";
                    document.getElementById("t-cpr").innerHTML = data[this.rowIndex].registration;
                    document.getElementById("t-telf").innerHTML = data[this.rowIndex].phone;



                });
            }

        }
    })
    // if the person uses the escape key, it will exit the resource
    document.onkeyup = function (data) {
        if (data.which == 116) {
            $.post('http://prp_policecentral/exit', JSON.stringify({}));
            return
        }
    };

    function checkForValue(json, value) {
        for (key in json) {
            if (typeof (json[key]) === "object") {
                return checkForValue(json[key], value);
            } else if (json[key] === value) {
                return true;
            }
        }
        return false;
    }

    $("#i-navn").on("keydown",function search(e) {
    	if(e.keyCode == 13) {
            let input = document.getElementById("i-navn").value;
             $.post('http://prp_policecentral/searchDB', JSON.stringify({
             	text: input
             }));
            return
	    }
    });
    
    

    

})
