function loadComparison() {

    removeResult();
    var kopisten = getKopists();
    var sef = "https://raw.githubusercontent.com/acdh-oeaw/bruckner-kopisten-static/main/xslt/sef/editions-facs-comparison.sef.json";
    var xml = "https://raw.githubusercontent.com/acdh-oeaw/bruckner-kopisten-static/main/data/editions/";

    SaxonJS.transform({
        stylesheetLocation: sef,
        sourceLocation: `${xml}${kopisten[0]}.xml`,
        destination: "serialized"
    }, "async")
    .then((data) => {
        var result = data.principalResult;
        $('#compare-column-one').append(result);
        // console.log(result);
    });

    SaxonJS.transform({
        stylesheetLocation: sef,
        sourceLocation: `${xml}${kopisten[1]}.xml`,
        destination: "serialized"
    }, "async")
    .then((data) => {
        var result = data.principalResult;
        $('#compare-column-two').append(result);
        // console.log(result);
    });

}

function removeResult() {
    
    var result = $(".comparison-result");
    if (result.length != 0) {
        result.remove();
    }

}

function getKopists() {

    //$("#compare-kopist-one").children().remove();
    var e1 = document.getElementById("compare-kopist-one");
    var kopist1 = e1.options[e1.selectedIndex].getAttribute("value");

    // $("#compare-kopist-two").children().remove();
    var e2 = document.getElementById("compare-kopist-two");
    var kopist2 = e2.options[e2.selectedIndex].getAttribute("value");

    return [kopist1, kopist2];

}
