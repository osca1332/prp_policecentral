


$(function () {


    var data = {
        "Persons":[
        {"firstName": "John","lastName": "Smith"},
        {"firstName": "Lars","lastName": "Smith"},
        ]
    }

    function display(bool) {
        if (bool) {
            $(".tablet").show();
        } else {
            $(".tablet").hide();
        }
    }


    display(true)

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
            } else {
                display(false)
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
            /* 
                Her skal vi sende request til databasen om en liste med alle navne der passer på input.
            
            */
            return;
	    }
	});

    $("#cross").click(function() {
        $.post('http://prp_policecentral/exit', JSON.stringify({}));
        return
    });

})
