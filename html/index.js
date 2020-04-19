$(function () {

    var name;
    var firstname;
    var phone;
    var cpr;
    function display(bool) {
        if (bool) {
            $(".tablet").show();
        } else {
            $(".tablet").hide();
        }
    }


    display(false)

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
            } else {
                display(false)
            }
        }

        if (item.type === "id") {
            document.getElementById("i-navn").value = item.first;
            document.getElementById("i-efternavn").value = item.name;
            document.getElementById("i-telf").value = item.phone;
            document.getElementById("i-cpr").value = `${item.cpr}-${item.uid}`;
            document.getElementById("i-alder").value = item.age;
            document.getElementByClassName("regi").innerHTML = item.record;
        }

        if (item.type === "idn") {
            document.getElementById("i-navn").value = "Ikke registreret";
            document.getElementById("i-efternavn").value = "Ikke registreret";
            document.getElementById("i-telf").value = "00000000";
            document.getElementById("i-cpr").value = "00000000-0";
            document.getElementById("i-alder").value = "...";
        }
    })
    // if the person uses the escape key, it will exit the resource
    document.onkeyup = function (data) {
        if (data.which == 116) {
            $.post('http://prp_policecentral/exit', JSON.stringify({}));
            return
        }
    };

    $(".plate").on("keydown",function search(e) {
    	if(e.keyCode == 13) {
            var plate = $("#nplate").val();
            if(document.getElementById("type").value == "c") {
                var p = plate.split(" ");
                $.post('http://prp_policecentral/nameCheck', JSON.stringify({
                    first: p[0],
                    last: p[1]
                }));
                return
            }

            if(document.getElementById("type").value == "t") {
                $.post('http://prp_policecentral/phoneCheck', JSON.stringify({
                    phone: plate,
                }));
                return
            }
            
    		$.post('http://prp_policecentral/licenseCheck', JSON.stringify({
    			text: plate,
    		}));
            return
	    }
	});

    $(".nplate").click(function() {
        $("table").show();
        $("table2").hide();
    });

    $(".pname").click(function() {
        $("table2").show();
        $("table").hide();
    });

    function pname()
    {
        $("table2").show();
        $("table").hide();
    }
})