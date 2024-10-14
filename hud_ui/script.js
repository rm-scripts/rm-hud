window.addEventListener('message', function (event) {
    const data = event.data;
    const { health, armor, hunger, thirst } = data;

    if (data.type === 'updateStatus') {
        if ($("#hud").css("display") != "flex") {
            $("#hud").css("display", "flex");
        }
        if (health) {
            $('#health-percentage').text(`${health}%`);
        }
        if (armor) {
            $('#armor-percentage').text(`${armor}%`);
        }
        if (hunger) {
            $('#hunger-percentage').text(`${hunger}%`);
        }
        if (thirst) {
            $('#thirst-percentage').text(`${thirst}%`);
        }
    } else if (data.type === 'talking') {
        const { radio, voice } = data;
        if (radio || voice) {
            if (radio) {
                $('#mic i').css({
                    "color": "violet",
                    "text-shadow": "0 0 10px violet"
                })
            } else {
                $('#mic i').css({
                    "color": "#fff700",
                    "text-shadow": "0 0 10px #fff700"
                })
            }
        } else {
            const selector = $("#mic i")
            if (selector.css("color") != "white") {
                $('#mic i').css({
                    "color": "white",
                    "text-shadow": "0 0 10px white"
                })
            }
        }
    } else if (data.type === "loadhud") {
        $("#hud").css("display", "flex");
    }
});
