function confirmDelete() {
    return confirm("Are you sure you want to delete this record?");
}

function validateForm() {
    let inputs = document.querySelectorAll("input[required]");
    for (let input of inputs) {
        if (input.value.trim() === "") {
            alert("Please fill all fields");
            return false;
        }
    }
    return true;
}
