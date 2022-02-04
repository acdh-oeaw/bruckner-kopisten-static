function loadComparison(el, id) {

    // choose html class for node to be removed
    removeColumnContent(`${id} .comparison-result`);
    $(id).html("");

    // options for saxonTransform
    // var kopisten = getKopists("compare-kopist-one", "compare-kopist-two");
    var kopist = el.value;
    var sef = "https://raw.githubusercontent.com/acdh-oeaw/bruckner-kopisten-static/main/xslt/sef/editions-facs-comparison.sef.json"; 
    var xml = "https://acdh-oeaw.github.io/bruckner-kopisten-static/";
    
    // column one result
    saxonTransfrom({
        stylesheet: sef,
        fileDir: xml,
        fileName: kopist,
        htmlID: id
    });

    removeColumnContent(`${id} .compare-placeholder`);

}

function saxonTransfrom(options) {

    SaxonJS.transform({
        stylesheetLocation: options.stylesheet,
        sourceLocation: `${options.fileDir}${options.fileName}.xml`,
        destination: "serialized"
    }, "async")
    .then((data) => {
        var result = data.principalResult;
        $(options.htmlID).append(result);
        // console.log(result);
    });

}

function removeColumnContent(id) {
    
    var result = $(id);
    if (result.length != 0) {
        result.remove();
    }

}

// function getKopists(htmlID1, htmlID2) {

//     //$("#compare-kopist-one").children().remove();
//     var e1 = document.getElementById(htmlID1);
//     var kopist1 = e1.options[e1.selectedIndex].getAttribute("value");

//     // $("#compare-kopist-two").children().remove();
//     var e2 = document.getElementById(htmlID2);
//     var kopist2 = e2.options[e2.selectedIndex].getAttribute("value");

//     return [kopist1, kopist2];

// }
