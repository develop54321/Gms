
"use strict";

const handleThemeUpdate = (cssVars) => {
    const root = document.querySelector(':root');
    const keys = Object.keys(cssVars);
    keys.forEach(key => {
        root.style.setProperty(key, cssVars[key]);
    });
}

function dynamicPrimaryColor(primaryColor) {
    primaryColor.forEach((item) => {
        item.addEventListener('input', (e) => {
            const cssPropName = `--primary-${e.target.getAttribute('data-id')}`;
            const cssPropName1 = `--primary-${e.target.getAttribute('data-id1')}`;
            const cssPropName2 = `--primary-${e.target.getAttribute('data-id2')}`;
            const cssPropName7 = `--primary-${e.target.getAttribute('data-id7')}`;
            const cssPropName8 = `--darkprimary-${e.target.getAttribute('data-id8')}`;
            const cssPropName3 = `--dark-${e.target.getAttribute('data-id3')}`;
            const cssPropName4 = `--transparent-${e.target.getAttribute('data-id4')}`;
            const cssPropName5 = `--dark-${e.target.getAttribute('data-id5')}`;
            const cssPropName6 = `--dark-${e.target.getAttribute('data-id6')}`;
            const cssPropName9 = `--transparentprimary-${e.target.getAttribute('data-id9')}`;
            handleThemeUpdate({
                [cssPropName]: e.target.value,
                [cssPropName1]: e.target.value + 95,
                [cssPropName2]: e.target.value,
                [cssPropName3]: e.target.value,
                [cssPropName4]: e.target.value,
                [cssPropName5]: e.target.value,
                [cssPropName6]: hexToRgba(e.target.value, 0.5),
                [cssPropName7]: e.target.value + 20,
                [cssPropName8]: e.target.value + 20,
                [cssPropName9]: e.target.value + 20,
            });
        });
    });
}

(function () {

    // Light theme color picker
    const dynamicPrimaryLight = document.querySelectorAll('input.color-primary-light');

    // themeSwitch(LightThemeSwitchers);
    dynamicPrimaryColor(dynamicPrimaryLight);

    // dark theme color picker

    const DarkDynamicPrimaryLight = document.querySelectorAll('input.color-primary-dark');

    // themeSwitch(DarkThemeSwitchers);
    dynamicPrimaryColor(DarkDynamicPrimaryLight);

    // tranparent theme color picker

    const transparentDynamicPrimaryLight = document.querySelectorAll('input.color-primary-transparent');

    // themeSwitch(transparentThemeSwitchers);
    dynamicPrimaryColor(transparentDynamicPrimaryLight);

    // tranparent theme bgcolor picker

    const transparentDynamicPBgLight = document.querySelectorAll('input.color-bg-transparent');

    // themeSwitch(transparentBgThemeSwitchers);
    dynamicPrimaryColor(transparentDynamicPBgLight);

    localStorageBackup();

})();

function localStorageBackup() {

    // if there is a value stored, update color picker and background color
    // Used to retrive the data from local storage
    if (localStorage.noaprimaryColor) {
        // document.getElementById('colorID').value = localStorage.noaprimaryColor;
        document.querySelector('html').style.setProperty('--primary-bg-color', localStorage.noaprimaryColor);
        document.querySelector('html').style.setProperty('--primary-bg-hover', localStorage.noaprimaryHoverColor);
        document.querySelector('html').style.setProperty('--primary-bg-border', localStorage.noaprimaryBorderColor);
        document.querySelector('html').style.setProperty('--primary-transparentcolor', localStorage.noaprimaryTransparent);
        document.querySelector('body').classList.add('light-mode');
        document.querySelector('body').classList.remove('dark-mode');

        $('#myonoffswitch3').prop('checked', true);
        $('#myonoffswitch6').prop('checked', true);
        $('#myonoffswitch1').prop('checked', true);
    }

    if (localStorage.noadarkPrimary) {
        // document.getElementById('darkPrimaryColorID').value = localStorage.noadarkPrimary;
        document.querySelector('html').style.setProperty('--primary-bg-color', localStorage.noadarkPrimary);
        document.querySelector('html').style.setProperty('--primary-bg-hover', localStorage.noadarkPrimary);
        document.querySelector('html').style.setProperty('--primary-bg-border', localStorage.noadarkPrimary);
        document.querySelector('html').style.setProperty('--dark-primary', localStorage.noadarkPrimary);
        document.querySelector('html').style.setProperty('--darkprimary-transparentcolor', localStorage.noadarkprimaryTransparent);
        document.querySelector('body').classList.add('dark-mode');
        document.querySelector('body').classList.remove('light-mode');

        $('#myonoffswitch2').prop('checked', true);

    }

    if (localStorage.noadarkBackgroundColor) {
        // document.getElementById('transparentBgColorID').value = localStorage.noadarkBackgroundColor;
        document.querySelector('html').style.setProperty('--dark-body', localStorage.noadarkBackgroundColor);
        document.querySelector('body').classList.add('dark-mode');
        document.querySelector('body').classList.remove('light-mode');
        $('#myonoffswitch2').prop('checked', true);
    }
    if (localStorage.noaBgImage) {
        document.querySelector('body')?.classList.add('dark-mode');
        let bgImg = localStorage.noaBgImage.split(' ')[0];
        document.querySelector('body')?.classList.add(bgImg);
        document.querySelector('body')?.classList.remove('light-mode');

        $('#myonoffswitch2').prop('checked', true);
    }

    if (localStorage.noalightMode) {
        document.querySelector('body')?.classList.add('light-mode');
        document.querySelector('body')?.classList.remove('dark-mode');
        $('#myonoffswitch3').prop('checked', true);
        $('#myonoffswitch6').prop('checked', true);
    }
    if (localStorage.noadarkMode) {
        document.querySelector('body')?.classList.remove('light-mode');
        document.querySelector('body')?.classList.add('dark-mode');
        $('#myonoffswitch2').prop('checked', true);
        $('#myonoffswitch5').prop('checked', true);
        $('#myonoffswitch8').prop('checked', true);
    }
    if(localStorage.noahorizontal){
        document.querySelector('body').classList.add('horizontal')
    }
    if(localStorage.noahorizontalHover){
        document.querySelector('body').classList.add('horizontal-hover')
    }
    if(localStorage.noartl){
        document.querySelector('body').classList.add('rtl')
    }
}

// triggers on changing the color picker
function changePrimaryColor() {

    $('#myonoffswitch3').prop('checked', true);
    $('#myonoffswitch6').prop('checked', true);
    checkOptions();

    var userColor = document.getElementById('colorID').value;
    localStorage.setItem('noaprimaryColor', userColor);
    // to store value as opacity 0.95 we use 95
    localStorage.setItem('noaprimaryHoverColor', userColor + 95);
    localStorage.setItem('noaprimaryBorderColor', userColor);
    localStorage.setItem('noaprimaryTransparent', userColor + 20);

    // removing dark theme properties
    localStorage.removeItem('noadarkPrimary')
    localStorage.removeItem('noadarkprimaryTransparent');
    localStorage.removeItem('noaBgImage');

    document.querySelector('body').classList.add('light-mode');
    document.querySelector('body').classList.remove('dark-mode');

    $('#myonoffswitch1').prop('checked', true);
    names()

    localStorage.setItem('noalightMode', true);
    localStorage.removeItem('noadarkMode');

    if ($('body').hasClass('bg-img1') || $('body').hasClass('bg-img2') || $('body').hasClass('bg-img3') || $('body').hasClass('bg-img4')) {
        $('body').removeClass('bg-img1')
        $('body').removeClass('bg-img2')
        $('body').removeClass('bg-img3')
        $('body').removeClass('bg-img4')
    }
}

function darkPrimaryColor() {

    var userColor = document.getElementById('darkPrimaryColorID').value;
    localStorage.setItem('noadarkPrimary', userColor);
    localStorage.setItem('noadarkprimaryTransparent', userColor + 20);
    $('#myonoffswitch5').prop('checked', true);
    $('#myonoffswitch8').prop('checked', true);
    checkOptions();

    // removing light theme data 
    localStorage.removeItem('noaprimaryColor')
    localStorage.removeItem('noaprimaryHoverColor')
    localStorage.removeItem('noaprimaryBorderColor')
    localStorage.removeItem('noaprimaryTransparent');
    localStorage.removeItem('noatransparentBgImgPrimary');
    localStorage.removeItem('noatransparentBgImgprimaryTransparent');

    localStorage.removeItem('noatransparentBgColor');
    localStorage.removeItem('noatransparentThemeColor');
    localStorage.removeItem('noatransparentPrimary');

    document.querySelector('body').classList.add('dark-mode');
    document.querySelector('body').classList.remove('light-mode');

    $('#myonoffswitch2').prop('checked', true);
    names()

    localStorage.setItem('noadarkMode', true);
    localStorage.removeItem('noalightMode');
}
function transparentBgColor() {

    $('#myonoffswitch3').prop('checked', false);
    $('#myonoffswitch6').prop('checked', false);
    $('#myonoffswitch5').prop('checked', false);
    $('#myonoffswitch8').prop('checked', false);
    var userColor = document.getElementById('transparentBgColorID').value;
    localStorage.setItem('noadarkBackgroundColor', userColor);

    // removing light theme data 
    // localStorage.removeItem('noadarkPrimary');
    localStorage.removeItem('noaprimaryColor')
    localStorage.removeItem('noaprimaryHoverColor')
    localStorage.removeItem('noaprimaryBorderColor')
    localStorage.removeItem('noaprimaryTransparent');
    document.querySelector('body').classList.remove('light-mode');
    document.querySelector('body').classList.add('dark-mode');

    $('#myonoffswitch2').prop('checked', true);
    checkOptions();
    if ($('body').hasClass('bg-img1') || $('body').hasClass('bg-img2') || $('body').hasClass('bg-img3') || $('body').hasClass('bg-img4')) {
        $('body').removeClass('bg-img1')
        $('body').removeClass('bg-img2')
        $('body').removeClass('bg-img3')
        $('body').removeClass('bg-img4')
    }

    localStorage.setItem('noadarkMode', true);
    localStorage.removeItem('noalightMode');
}


function bgImage(e) {

    $('#myonoffswitch3').prop('checked', false);
    $('#myonoffswitch6').prop('checked', false);
    $('#myonoffswitch5').prop('checked', false);
    $('#myonoffswitch8').prop('checked', false);
    let imgID = e.getAttribute('class');
    localStorage.setItem('noaBgImage', imgID);

    // removing light theme data 
    localStorage.removeItem('noadarkPrimary');
    localStorage.removeItem('noaprimaryColor')
    document.querySelector('body')?.classList.remove('light-mode');
    document.querySelector('body')?.classList.add('dark-mode');

    $('#myonoffswitch2').prop('checked', true);
    checkOptions();
}

// to check the value is hexa or not


const isValidHex = (hexValue) => /^#([A-Fa-f0-9]{3,4}){1,2}$/.test(hexValue)

const getChunksFromString = (st, chunkSize) => st.match(new RegExp(`.{${chunkSize}}`, "g"))
// convert hex value to 256
const convertHexUnitTo256 = (hexStr) => parseInt(hexStr.repeat(2 / hexStr.length), 16)
// get alpha value is equla to 1 if there was no value is asigned to alpha in function
const getAlphafloat = (a, alpha) => {
    if (typeof a !== "undefined") { return a / 255 }
    if ((typeof alpha != "number") || alpha < 0 || alpha > 1) {
        return 1
    }
    return alpha
}
// convertion of hex code to rgba code 
function hexToRgba(hexValue, alpha) {
    if (!isValidHex(hexValue)) { return null }
    const chunkSize = Math.floor((hexValue.length - 1) / 3)
    const hexArr = getChunksFromString(hexValue.slice(1), chunkSize)
    const [r, g, b, a] = hexArr.map(convertHexUnitTo256)
    return `rgba(${r}, ${g}, ${b}, ${getAlphafloat(a, alpha)})`
}


let myVarVal, myVarVal1, myVarVal2, myVarVal3

function names() {

    let primaryColorVal = getComputedStyle(document.documentElement).getPropertyValue('--primary-bg-color').trim();

    //get variable
    myVarVal = localStorage.getItem("noaprimaryColor") || localStorage.getItem("noadarkPrimary") || localStorage.getItem("noatransparentPrimary") || localStorage.getItem("noatransparentBgImgPrimary") || primaryColorVal;

    if (document.querySelector('#chartD') !== null) {
        sales();
    }

    let colorData = hexToRgba(myVarVal || primaryColorVal, 0.1)
    document.querySelector('html').style.setProperty('--primary01', colorData);

    let colorData1 = hexToRgba(myVarVal || primaryColorVal, 0.2)
    document.querySelector('html').style.setProperty('--primary02', colorData1);

    let colorData2 = hexToRgba(myVarVal || primaryColorVal, 0.3)
    document.querySelector('html').style.setProperty('--primary03', colorData2);

    let colorData3 = hexToRgba(myVarVal || primaryColorVal, 0.6)
    document.querySelector('html').style.setProperty('--primary06', colorData3);

    let colorData4 = hexToRgba(myVarVal || primaryColorVal, 0.9)
    document.querySelector('html').style.setProperty('--primary09', colorData4);

}
names()

