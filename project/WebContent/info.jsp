<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="kr.dgswhs.berich.bean.*" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="./upload.js"></script>
    <title></title>
    <style type="text/css">
        .wrap {position: absolute;left: 0;bottom: 40px;width: 288px;height: 132px;margin-left: -144px;text-align: left;overflow: hidden;font-size: 12px;font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;line-height: 1.5;}
        .wrap * {padding: 0;margin: 0;}
        .wrap .info {width: 286px;height: 120px;border-radius: 5px;border-bottom: 2px solid #ccc;border-right: 1px solid #ccc;overflow: hidden;background: #fff;}
        .wrap .info:nth-child(1) {border: 0;box-shadow: 0px 1px 2px #888;}
        .info .title {padding: 5px 0 0 10px;height: 30px;background: #eee;border-bottom: 1px solid #ddd;font-size: 18px;font-weight: bold;}
        .info .close {position: absolute;top: 10px;right: 10px;color: #888;width: 17px;height: 17px;background: url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');}
        .info .close:hover {cursor: pointer;}
        .info .body {position: relative;overflow: hidden;}
        .info .desc {position: relative;margin: 13px 0 0 90px;height: 75px;}
        .desc .ellipsis {overflow: hidden;text-overflow: ellipsis;white-space: nowrap;}
        .desc .jibun {font-size: 11px;color: #888;margin-top: -2px;}
        .info .img {position: absolute;top: 6px;left: 5px;width: 73px;height: 71px;border: 1px solid #ddd;color: #888;overflow: hidden;}
        .info:after {content: '';position: absolute;margin-left: -12px;left: 50%;bottom: 0;width: 22px;height: 12px;background: url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
        .info .link {color: #5085BB;}
        .file {visibility: hidden;}
    </style>
    <style>
        .wrap {position: absolute;left: 0;bottom: 40px;width: 150px;height: 150px;margin-left: -75px;text-align: center;overflow: hidden;font-size: 12px;font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;line-height: 1.5;}
        .wrap * {padding: 0;margin: 0;}
        .wrap .info {width: 286px;height: 120px;border-radius: 5px;border-bottom: 2px solid #ccc;border-right: 1px solid #ccc;overflow: hidden;background: #fff;}
        .wrap .info:nth-child(1) {border: 0;box-shadow: 0px 1px 2px #888;}
        .info .title {text-align:left; padding: 5px; height: 25px;background: #eee;border-bottom: 1px solid #ddd;font-size: 18px;font-weight: bold;}
        .info .close {position: absolute;top: 10px;right: 10px;color: #888;width: 17px;height: 17px;background: url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');}
        .info .close:hover {cursor: pointer;}
        .info .body {position: relative;overflow: hidden;}
        .info .desc {position: relative;margin: 13px 0 0 90px;height: 75px;}
        .info .img {position: absolute;top: 6px;left: 5px;width: 140px;height: 71px;border: 1px solid #ddd;color: #888;overflow: hidden;}
        .info:after {content: '';position: absolute;margin-left: -12px;left: 50%;bottom: 20;width: 22px;height: 12px;background: url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
    </style>
</head>

<body style="background-color: #C0AB8C">
	
	<%
	DataBean item = null;
	String itemId = request.getParameter("itemId");
	if(itemId == null) out.println("Error");
	else{
		ArrayList<DataBean> list = DBBean.getInstance().select(Integer.parseInt(itemId));
		item = list.get(0);
		String imageUrl = item.getImageUrl();
		String itemName = item.getItemName();
		int itemCnt = item.getItemCnt();
		String itemDesc = item.getItemDesc();
		Double lat = item.getLat();
		Double lng = item.getLng();
	%>
    <table>
        <tbody>
        <tr>
            <td valign="top">
                <div id="map" style="width:700px;height:650px; margin: 30px;"></div>                                          <!--지도화면-->
                <script type="text/javascript"
                        src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c59727be163045e7f3830a65c8a89d9e"></script>
                <div id="info" style="background-color: #C0AB8C; border-color: white; border: solid 10px; width: 700px; height: 650px; position: absolute; top: 30px; \right: 10px; margin-right:50px;">                        <!--왼쪽 아래 화면 폼-->
                    <form action="Delete"name="form" method='get' enctype="multipart/form-data" class="form-inline" style="padding:10px;">
                        <table>
                            <tr>
                                <h2 style="padding: 0px 25px; font-weight: bold; font-size: 50px">Make treasure</h2>
                                <td style="width: 375px; padding: 40px;">
                                	<input type="hidden" name="itemId" value="<%=itemId %>"/>
                                    <div class="form-group">
                                        <label for="name" style="font-size: 20px">Name: </label>
                                        <input type="text" class="form-control" id="name" placeholder="Enter name" name="itemName" value = '<%=itemName%>' readonly>
                                    </div>
                                    <div class="form-group" style="margin: 20px 0px">
                                        <label for="count"style="font-size: 20px">Count:</label>
                                       	<%=itemCnt%>
                                    </div>
                                    <!--  file upload  -->
                                </td>
                                <td style="width: 300px; padding: 8px">
                                    <label style="font-size: 20px">Info:</label>
                                    <textarea rows="6" cols="30" class="form-control" name="itemDesc" readonly><%=itemDesc%></textarea>
                                </td>

                            </tr>
                        </table>
                        <button class="btn btn-lg btn-block" style="padding: 10px; top: 100px; font-size: 20px;">Delete</button>
                    </form>
                </div>
            </td>
        </tr>
        </tbody>
    </table>

    <div id="map" style="width:100%;height:350px;"></div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c59727be163045e7f3830a65c8a89d9e"></script>
<script>
    var mapContainer = document.getElementById('map'), // 지도의 중심좌표
        mapOption = {
            center: new daum.maps.LatLng(33.451475, 126.570528), // 지도의 중심좌표
            level: 3 // 지도의 확대 레벨
        };

    var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

    // 지도에 마커를 표시합니다
    var marker = new daum.maps.Marker({
        map: map,
        position: new daum.maps.LatLng(<%=lat%>, <%=lng%>)
    });

    // 커스텀 오버레이에 표시할 컨텐츠 입니다
    // 커스텀 오버레이는 아래와 같이 사용자가 자유롭게 컨텐츠를 구성하고 이벤트를 제어할 수 있기 때문에
    // 별도의 이벤트 메소드를 제공하지 않습니다
    var content = '<div class="wrap">' +
        '    <div class="info">' +
        '        <div class="title">' +
        '            <%=itemName%>' +
        '            <div class="close" onclick="closeOverlay()" title="닫기"></div>' +
        '        </div>' +
        '        <div class="body">' +
        '            <div class="img">' +
        '                <img src="<%=imageUrl%>" width="73" height="70">' +
        '           </div>' +
        '            <div class="desc">' +
        '            </div>' +
        '        </div>' +
        '    </div>' +
        '</div>';

    // 마커 위에 커스텀오버레이를 표시합니다
    // 마커를 중심으로 커스텀 오버레이를 표시하기위해 CSS를 이용해 위치를 설정했습니다
    var overlay = new daum.maps.CustomOverlay({
        content: content,
        map: map,
        position: marker.getPosition()
    });

    // 마커를 클릭했을 때 커스텀 오버레이를 표시합니다
    daum.maps.event.addListener(marker, 'click', function() {
        overlay.setMap(map);
    });

    // 커스텀 오버레이를 닫기 위해 호출되는 함수입니다
    function closeOverlay() {
        overlay.setMap(null);
    }
</script>
    <%
}
%>
</body>
</html>