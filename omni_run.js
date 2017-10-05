// https://discourse.omnigroup.com/t/a-hello-world-document-testing-omnijs-code-from-jxa-text-editor/30817

(function () {
    'use strict';
    // Code for OmniJS Context ------------------------------------------------

    // main :: Dictionary -> Console IO ()
    function main() {
        // New canvas created and selected in active OmniGraffle document
        var cnv = addCanvas();
        cnv.layoutInfo.automaticLayout = false;
        ['Right', 'Down'].forEach(function (x) {
            cnv['autosizes' + x] = true;
        });
        document.windows[0].selection.view.canvas = cnv;

        // New shape added to new canvas
        var shp = cnv.newShape();
        shp.cornerRadius = 9;
        shp.text = "Hello to the OmniJS world from JXA!!!";
        shp.textSize = 12;
        shp.geometry = new Rect(100.00, 100.00, 100.00, 100.00);
    }


    // Code for JXA Context----------------------------------------------------

    // Using JXA to url-encode and then run the OmniJS code:
    var app = Application.currentApplication();
    app.includeStandardAdditions = true;

    var
        // Javascript can convert a function to a source code string ...
        strCode = '(' + main.toString() + ')();',
        // Standard prefix, or omnioutliner
        strPrefix = 'omnigraffle:///omnijs-run?script=',
        // URL-encode the omniJS source code
        strOmniJSURL = strPrefix + encodeURIComponent(strCode);

    // Make sure that there is an active document in OmniGraffle 7.3 test
    var og = Application('OmniGraffle'),
        ds = og.documents,
        d = ds.length > 0 ? ds.at(0) : ds.push(og.Document());

    // Run the omniJS url
    og.activate();
    app.openLocation(strOmniJSURL);

    // Return the plain text of the OmniJS code for visual checking
    // return strCode;
})();
