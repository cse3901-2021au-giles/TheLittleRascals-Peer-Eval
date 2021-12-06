add_student = () => {

    var x = document.getElementById("add-user")
    if (x.classList.contains("none")) {
        x.classList.remove("none")
    } else {
        x.classList.add("none")
    }

}


var t = setInterval(function () {
    var ele =document.getElementsByClassName('notice')[0];
    ele.style.visibility = 'hidden';
}, 2000);

