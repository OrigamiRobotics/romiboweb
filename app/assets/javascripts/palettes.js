/**
 * Created by johnlee on 2/18/14.
 */


function loadButtonDetails(threeBasedIndex) {
    var jsonString = $("#jsonText").val();
    var palette = $.parseJSON(jsonString);
    for(var i in palette.actions) {
    var index = palette.actions[i].threeBasedIndex;
    if (index == threeBasedIndex) {
    $("#buttonTitle").val(palette.actions[i].buttonTitle);
    $("#speechPhrase").val(palette.actions[i].speechPhrase);
    $("#speechSpeed").val(palette.actions[i].speechSpeedRate);
    $("#buttonColor").val(palette.actions[i].color);
    }
}
}

function importJSON(e) {
    $("#paletteGroup").find('.active').removeClass('active');
    e.classList.add("active");

    layer.removeChildren();
    var jsonString = $("#jsonText").val();
    var palette = $.parseJSON(jsonString);
    var paletteName = palette.name;
    $("#paletteName").val(e.innerHTML);
    var x = 1;
    var y = 10;
    for(var n in palette.actions) {
    // anonymous function to induce scope
    // http://stackoverflow.com/questions/5815757/what-exactly-is-the-point-of-this-function-construct-why-is-it-needed
    (function() {
    var i = n
    var title = palette.actions[i].buttonTitle;
    var speech = palette.actions[i].speechPhrase;
    var threeBasedIndex = palette.actions[i].threeBasedIndex;
    var kinText = createText(title);
    var kinButton = createButton(kinText, palette.actions[i].color);
    var kinGroup = createGroup(i, x, y);

    kinGroup.on('click', function() {
    loadButtonDetails(threeBasedIndex);
    });
kinGroup.add(kinButton).add(kinText);
layer.add(kinGroup);
x = x + kinText.width() + 1;
if (x > 500) {
    x = 1;
    y = 51;
    }
})();
}
stage.add(layer);
}

function createText(text) {
    var kinText = new Kinetic.Text({
    fontSize: 20,
    fontFamily: 'Calibri',
    text: text,
    fill: 'white',
    padding: 10
    });
return kinText;
}

function createButton(kinText, color) {
    var kinRect = new Kinetic.Rect({
    width: kinText.width(),
    height: kinText.height(),
    fill: color,
    stroke: 'white',
    strokeWidth: 1,
    cornerRadius: 5
    });

return kinRect;
}

function createGroup(i, x, y) {
    // bound inside a circle
    var kinGroup = new Kinetic.Group({
    x: x,
    y: y,
    draggable: false,
    dragBoundFunc: function(pos) {
    var newY = pos.y < 10 ? 10 : pos.y;
    return {
    x: pos.x,
    y: newY
    };
}
});
return kinGroup;
}

