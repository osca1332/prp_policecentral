$(function () {
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
            $("#form__group").hide();
            $(".identity").show();
        }
    })
    // if the person uses the escape key, it will exit the resource
    document.onkeyup = function (data) {
        if (data.which == 116) {
            $.post('http://prp_policecentral/exit', JSON.stringify({}));
            return
        }
    };

    $("#name").on("keydown",function search(e) {
    	if(e.keyCode == 13) {
    		$.post('http://prp_policecentral/licenseCheck', JSON.stringify({
    			text: $(this).val()
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