
function parseCatalogue(data){
    var textBody = data.substring(data.indexOf(">", data.indexOf("<body")) + 1);
    var la = document.createElement("div");
    la.innerHTML = textBody;
    var listA = $(la).find("#list").find("dd");
    var infos = new Array();
    for(var i = 0;i < listA.length;i ++){
        var info = new Object();
        info["url"] = $(listA[i]).find("a").attr("href");
        info["name"] = $(listA[i]).find("a").html();
        infos.push(info);
    }
    return infos;
}

function parseContent(data){
    var textBody = data.substring(data.indexOf(">", data.indexOf("<body")) + 1);
    var la = document.createElement("div");
    la.innerHTML = textBody;
    $(la).find("#chaptercontent").find("p").remove();
    $(la).find("#chaptercontent").find("center").remove();
    var content = $(la).find("#chaptercontent").html();
    return content;
}

function getChapterList(data){
    var textBody = data.substring(data.indexOf(">", data.indexOf("<body")) + 1);
    var la = document.createElement("div");
    la.innerHTML = textBody;
    var listA = $(la).find(".chapterlist").find("p");
    var infos = new Array();
    for(var i = 0;i < listA.length;i ++){
        var info = new Object();
        info["url"] = $(listA[i]).find("a").attr("href");
        info["name"] = $(listA[i]).find("a").html();
        infos.push(info);
    }
    return infos;
}

function getRecentlyChapter(data){
    var textBody = data.substring(data.indexOf(">", data.indexOf("<body")) + 1);
    var la = document.createElement("div");
    la.innerHTML = textBody;
    var listA = $(la).find(".directoryArea").find("p");
    var infos = new Array();
    for(var i = 0;i < listA.length;i ++){
        var info = new Object();
        info["url"] = $(listA[i]).find("a").attr("href");
        info["name"] = $(listA[i]).find("a").html();
        infos.push(info);
    }
    return infos;
}


function searchArticleList(data){
    var textBody = data.substring(data.indexOf(">", data.indexOf("<body")) + 1);
    var la = document.createElement("div");
    la.innerHTML = textBody;
    var ArticleList = $(la).find(".hot_sale");
    var ArticleiInfos = new Array();
    for(var i = 0;i < ArticleList.length;i ++){
        var info = new Object();
        info["url"] = $(ArticleList[i]).find("a").attr("href");
        var list = $(ArticleList[i]).find("a").find("p");
        info["title"] = $(list[0]).html();
        info["author"] = $(list[1]).html();
        info["discripe"] = $(list[2]).html();
        ArticleiInfos.push(info);
    }
    return ArticleiInfos;
}
