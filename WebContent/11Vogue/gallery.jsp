<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta
            name="description"
            content="컬렉션부터 스타일, 쇼핑, 뷰티, 라이프스타일, 셀러브리티까지 지금 가장 핫한 트렌드 소개"
        />
        <title>Gallery | 보그 코리아 (Vogue Korea) 2022</title>
        <!-- 탭메뉴 출력 아이콘 -->
        <link
            rel="shortcut icon"
            href="./images/icon.jpg"
            type="image/x-icon"
        />
        <!-- 폰티스토 아이콘 CSS -->
        <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/fontisto@v3.0.4/css/fontisto/fontisto.min.css"
        />
        <!-- 스와이퍼 CSS -->
        <link rel="stylesheet" href="./css/swiper-bundle.min.css" />
        <!-- 갤러리 페이지 CSS -->
        <link rel="stylesheet" href="./css/gallery.css" />
        <!-- 미디어쿼리 CSS -->
        <link rel="stylesheet" href="./css/media.css">
        <!-- 제이쿼리 라이브러리 + UI -->
        <script src="./js/jquery-3.6.1.min.js"></script>
        <script src="./js/jquery-ui.min.js"></script>
        <!-- 부드러운 스크롤 JS플러그인 호출 -->
        <script src="./js/smoothScroll20.js"></script>
        <!-- 스와이퍼 JS -->
        <script src="./js/swiper-bundle.min.js"></script>
        <!-- 공통 JS 호출! -->
        <script src="./js/linksys.js"></script>
        <script src="./js/common.js"></script>
        <!-- 갤러리 페이지 JS호출 -->
        <script src="./js/gallery.js"></script>
    </head>
    <body>
    	<!-- 로그인세션처리 인클루드 -->
        <%@ include file="include/loginSession.jsp" %>
        <!-- 1. 상단영역 -->
        <%@ include file="include/top.jsp" %>
        <!-- 2. 메인영역 -->
        <div id="cont" class="bgc">
            <main class="cont ibx">
                <!-- 2-1. 카테고리 페이지 탑영역 -->
                <header class="ctop">
                    <!-- 2-1-1. 서브타이틀 -->
                    <h2 class="stit">Gallery</h2>
                </header>
                <!-- 2-2. 갤러리 페이지 컨텐츠 박스 -->
                <section class="scont">
                    <!-- Swiper -->
                    <div class="swiper mySwiper">
                        <div class="swiper-wrapper">
                            <div class="swiper-slide">
                                <img
                                    src="images/people/cont2-1a.jpg"
                                    alt="보그갤러리이미지"
                                />
                            </div>
                            <div class="swiper-slide">
                                <img
                                    src="images/fashion/cont1-2b.jpg"
                                    alt="보그갤러리이미지"
                                />
                            </div>
                            <div class="swiper-slide">
                                <img
                                    src="images/people/cont2-3a.jpg"
                                    alt="보그갤러리이미지"
                                />
                            </div>
                            <div class="swiper-slide">
                                <img
                                    src="images/fashion/cont2-1b.jpg"
                                    alt="보그갤러리이미지"
                                />
                            </div>
                            <div class="swiper-slide">
                                <img
                                    src="images/fashion/cont2-2b.jpg"
                                    alt="보그갤러리이미지"
                                />
                            </div>
                            <div class="swiper-slide">
                                <img
                                    src="images/fashion/cont2-3b.jpg"
                                    alt="보그갤러리이미지"
                                />
                            </div>
                            <div class="swiper-slide">
                                <img
                                    src="images/beauty/cont1-2a.jpg"
                                    alt="보그갤러리이미지"
                                />
                            </div>
                            <div class="swiper-slide">
                                <img
                                    src="images/beauty/cont2-3b.jpg"
                                    alt="보그갤러리이미지"
                                />
                            </div>
                            <div class="swiper-slide">
                                <img
                                    src="images/beauty/cont1-1b.jpg"
                                    alt="보그갤러리이미지"
                                />
                            </div>
                        </div>
                        <div class="swiper-button-next"></div>
                        <div class="swiper-button-prev"></div>
                        <div class="swiper-pagination"></div>
                    </div>
                </section>
            </main>
        </div>
        <!-- 3. 하단영역 -->
        <%@ include file="include/info.jsp" %>
    </body>
</html>
