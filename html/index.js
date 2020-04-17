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
            name = item.name;
            firstname = item.first;
            phone = item.phone;
            cpr = item.cpr
            $("#nplate").val() = name;
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
    		$.post('http://prp_policecentral/licenseCheck', JSON.stringify({
    			text: $("#nplate").val(),
                type: $("#type").val()
    		}));
            return
	    }
	});



    $("#331").click(function () {
        $("#pTjek").show();
        $("#eTjek").hide();
        return
    })

     $("#332").click(function () {
        $("#pTjek").hide();
        $("#eTjek").show();
        
        return
    })
})