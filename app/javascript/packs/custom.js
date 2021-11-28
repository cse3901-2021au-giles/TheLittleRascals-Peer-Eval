add_student = () => {

    var x = document.getElementById("add-user")
    if (x.classList.contains("none")) {
        x.classList.remove("none")
    } else {
        x.classList.add("none")
    }

}