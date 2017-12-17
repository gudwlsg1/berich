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
</head>

<body style="background-color: #C0AB8C">
	<%
	DataBean item = null;
	String itemId = request.getParameter("itemId");
	if(itemId == null) out.println("Error");
	else{
		out.println(itemId);
		ArrayList<DataBean> list = DBBean.getInstance().select(Integer.parseInt(itemId));
		item = list.get(0);
		String imageUrl = item.getImageUrl();
		String itemName = item.getItemName();
		int itemCnt = item.getItemCnt();
		String itemDesc = item.getItemDesc();
		out.println(itemDesc);
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
                        <button class="btn  btn-lg btn-block" type="button" id="back" style="padding: 10px; font-size: 20px; ">Back</button>
                    </form>
                </div>
            </td>
        </tr>
        </tbody>
    </table>

    <div id="map" style="height:50px;"></div>
    <div id="clickLatlng"></div>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c59727be163045e7f3830a65c8a89d9e"></script>
    <script>
        var mapContainer = document.getElementById('map'), // 지도를 표시할 div
            mapOption = {
                center: new daum.maps.LatLng(<%=lat%>, <%=lng%>), // 지도의 중심좌표
                level: 3 // 지도의 확대 레벨
            };
        var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
        // 지도를 클릭한 위치에 표출할 마커입니다
        var marker = new daum.maps.Marker({
            position: map.getCenter()
        });
        marker.setMap(map);
        // 지도에 클릭 이벤트를 등록합니다
        daum.maps.event.addListener(map, 'click', function(mouseEvent) {
// 클릭한 위도, 경도 정보를 가져옵니다
            var latlng = mouseEvent.latLng;
// 마커 위치를 클릭한 위치로 옮깁니다
            marker.setPosition(latlng);
            document.getElementById('lat').value=latlng.getLat();
            document.getElementById('lng').value=latlng.getLng();
            var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
            message += '경도는 ' + latlng.getLng() + ' 입니다';
            var resultDiv = document.getElementById('clickLatlng');
            resultDiv.innerHTML = message;
        });
    </script>
    <%
}
%>
</body>
</html>