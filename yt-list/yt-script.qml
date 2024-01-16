import QtQml 2.0
import QOwnNotesTypes 1.0

Script {

    function init() {      
        script.registerCustomAction("insertYTLink", "Insert YT link", "YTLink");
    }

    function customActionInvoked(identifier) {
        switch (identifier) {
            case "insertYTLink":
                var result = script.inputDialogGetText("Insert link with preview", "Please enter YT link", "https://www.youtube.com/watch?v=CXs71qEvLNU");
                console.log(result);
                var note = script.currentNote();
                var text = note.noteText;

                var id = getYouTubeVideoID(result);

                text += "  | | |\r";
                text += "|---|---|\r";
                text += `|Test|<img src="https://img.youtube.com/vi/${id}/0.jpg" alt="${id}" width="160" height="103"/>|`;
                console.log("Text: " + text);
                note.noteText = text;

                var pathToNote = note.fullNoteFilePath;
                console.log(`Path: ${pathToNote}`);
                var writingResult = script.writeToFile(pathToNote, text);
                console.log(writingResult);
                break;
        }
    }

    function getYouTubeVideoID(url){
        var id = url.split('v=')[1];
        var ampPosition = id.indexOf('&');
        if (ampPosition != -1){
            id = id.substring(0, ampPosition);
        }
        return id;
    }
}
