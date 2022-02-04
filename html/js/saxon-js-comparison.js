function loadComparison() {

    // choose html class for node to be removed
    removeColumnContent(".comparison-result");

    // options for saxonTransform
    var kopisten = getKopists("compare-kopist-one", "compare-kopist-two");
    var sef = "https://raw.githubusercontent.com/acdh-oeaw/bruckner-kopisten-static/main/xslt/sef/editions-facs-comparison.sef.json"; 
    var xml = "https://acdh-oeaw.github.io/bruckner-kopisten-static/";
    
    // column one result
    saxonTransfrom({
        stylesheet: sef,
        fileDir: xml,
        fileName: kopisten[0],
        htmlID: "#compare-column-one"
    });
    
    // column two result
    saxonTransfrom({
        stylesheet: sef,
        fileDir: xml,
        fileName: kopisten[1],
        htmlID: "#compare-column-two"
    }); 

    removeColumnContent(".compare-placeholder");

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

function removeColumnContent(htmlClass) {
    
    var result = $(htmlClass);
    if (result.length != 0) {
        result.remove();
    }

}

function getKopists(htmlID1, htmlID2) {

    //$("#compare-kopist-one").children().remove();
    var e1 = document.getElementById(htmlID1);
    var kopist1 = e1.options[e1.selectedIndex].getAttribute("value");

    // $("#compare-kopist-two").children().remove();
    var e2 = document.getElementById(htmlID2);
    var kopist2 = e2.options[e2.selectedIndex].getAttribute("value");

    return [kopist1, kopist2];

}
