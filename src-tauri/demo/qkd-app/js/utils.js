function getLang(selectObject) {
    var value = selectObject.value;
    console.log(value);

    var myurl = "";
    if (value === "zh") {
        myurl = "./index.html";
    }
    else if (value === "en") {
        myurl = "./index.en.html";
    }
    else if (value === "es") {
        myurl = "./index.es.html";
    }
    console.log(myurl);    

    var a = document.createElement('a');
    a.setAttribute('href', myurl);
    a.setAttribute('id', 'js_a');
    // avoid adding twice
    var js_a = document.getElementById('js_a');
    if (js_a) {
        document.body.removeChild('js_a');
    }
    document.body.appendChild(a);
    a.click();
}
