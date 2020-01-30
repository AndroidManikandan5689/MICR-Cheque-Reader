var exec = require('cordova/exec');

var MicrReaderPlugin = {
    recognizeText: function (image, language, successCallback, errorCallback) {
        exec(successCallback, errorCallback, "MicrReaderPlugin", "recognizeText", [language, image]);
    },
    loadLanguage: function (language, successCallback, errorCallback) {
        exec(successCallback, errorCallback, "MicrReaderPlugin", "loadLanguage", [language]);
    }
};
module.exports = TesseractPlugin;
