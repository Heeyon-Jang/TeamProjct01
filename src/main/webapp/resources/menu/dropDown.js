// 근태 관리
const menu = document.querySelector(".dropmenu");
const subBar = document.querySelector(".sub");
const menuUp = document.querySelector(".menu-up");
const menuDown = document.querySelector(".menu-down");

let subToggle = true;

function show_sub(){
  if(subToggle){
    subBar.style.height="80px";
    subToggle = !subToggle;
    menuUp.classList.remove("btn-display");
    menuDown.classList.add("btn-display");
  }else{
    subBar.style.height="0px";
    subToggle = !subToggle;
    menuUp.classList.add("btn-display");
    menuDown.classList.remove("btn-display");
  }
}

// 게시판
const menu1 = document.querySelector(".dropmenu1");
const subBar1 = document.querySelector(".sub1");
const menuUp1 = document.querySelector(".menu-up1");
const menuDown1 = document.querySelector(".menu-down1");

let  subToggle1 = true;
function show_sub1(){
  if(subToggle1){
    subBar1.style.height="80px";
    subToggle1 = !subToggle1;
    menuUp1.classList.remove("btn-display");
    menuDown1.classList.add("btn-display");
  }else{
    subBar1.style.height="0px";
    subToggle1 = !subToggle1;
    menuUp1.classList.add("btn-display");
    menuDown1.classList.remove("btn-display");
  }
}

// 쪽지
const menu2 = document.querySelector(".dropmenu2");
const subBar2 = document.querySelector(".sub2");
const menuUp2 = document.querySelector(".menu-up2");
const menuDown2 = document.querySelector(".menu-down2");

let  subToggle2 = true;
function show_sub2(){
  if(subToggle2){
    subBar2.style.height="120px";
    subToggle2 = !subToggle2;
    menuUp2.classList.remove("btn-display");
    menuDown2.classList.add("btn-display");
  }else{
    subBar2.style.height="0px";
    subToggle2 = !subToggle2;
    menuUp2.classList.add("btn-display");
    menuDown2.classList.remove("btn-display");
  }
}

// 관리자
const menu3 = document.querySelector(".dropmenu3");
const subBar3 = document.querySelector(".sub3");
const menuUp3 = document.querySelector(".menu-up3");
const menuDown3 = document.querySelector(".menu-down3");

let  subToggle3 = true;
function show_sub3(){
  if(subToggle3){
    subBar3.style.height="190px";
    subToggle3 = !subToggle3;
    menuUp3.classList.remove("btn-display");
    menuDown3.classList.add("btn-display");
  }else{
    subBar3.style.height="0px";
    subToggle3 = !subToggle3;
    menuUp3.classList.add("btn-display");
    menuDown3.classList.remove("btn-display");
  }
}

document.getElementById("mobile-btn").addEventListener("click",function(){
    let inner = document.getElementsByClassName("container-inner-bbs");
    let nav = document.getElementsByClassName("nav");
    nav[0].classList.toggle("toggle-block");
    inner[0].classList.toggle("toggle-none");
});