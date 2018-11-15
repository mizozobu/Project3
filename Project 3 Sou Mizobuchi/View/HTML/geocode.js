var getSelectionOffset = function () {
    var start = document.getSelection().baseOffset;
    var end = document.getSelection().focusOffset;
    var xpath = '';
    try {
        xpath = getXpath(getSelection().anchorNode);
    } catch (err) {
    }
    
    return xpath + '@' + (start < end ? start : end);
};

var getXpath = function (element) {
    if (element && element.id) {
        return '//*[@id=\"' + element.id + '\"]';
    }
    
    if (element.tagName != undefined && element.tagName.toLowerCase() === 'body') {
        return '/html/body';
    }
    
    return getElementTreeXPath(element);
};

var getElementTreeXPath = function (element) {
    var index = 1;
    var sibling;
    
    if (element.nodeType === Node.TEXT_NODE) {
        sibling = element.previousSibling;
        for (; sibling; sibling = sibling.previousSibling) {
            if (sibling.nodeType === Node.TEXT_NODE) {
                ++index
            }
        }
        return getXpath(element.parentNode) + '/text()[' + index + ']';
    }
    
    if (element.nodeType === Node.ELEMENT_NODE) {
        sibling = element.previousSibling;
        
        for (; sibling; sibling = sibling.previousSibling) {
            if (sibling.nodeName === element.nodeName) {
                ++index
            }
        }
        
        return getXpath(element.parentNode) + '/' + element.tagName.toLowerCase() + '[' + index + ']';
    }
    
    return index;
};