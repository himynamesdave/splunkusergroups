$(document).ready(function () {
    $("input").on("input change", function() {
        $group = $(this).closest(".form-group")
        if ($(this).val()) {
            $group.tooltip("destroy").removeClass("has-error").addClass("has-success")
        }
        else {
            $group.tooltip("destroy").removeClass("has-success").addClass("has-error")   
        }
    })
});