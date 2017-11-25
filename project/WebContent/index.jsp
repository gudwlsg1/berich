<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title></title>
    <style type="text/css">
        .item1:active{
            width: 500px;
            height: 300px;
            background-color: darkgray;
        }
    </style>
</head>

<body>
<%
	String message = (String)session.getAttribute("message");
	if(message != null)
		out.print(message);
%>
<table>
    <tbody>
    <tr>
        <td valign="top">
            <div id="map" style="width:700px;height:400px; margin: 30px;"></div>                                          <!--지도화면-->
            <script type="text/javascript"
                    src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c59727be163045e7f3830a65c8a89d9e"></script>
            <script>
                var container = document.getElementById('map');
                var options = {
                    center: new daum.maps.LatLng(33.450701, 126.570667),
                    level: 3
                };
                var map = new daum.maps.Map(container, options);
            </script>

            <div id="info" style="background-color: gray; width: 700px; margin: 30px;">                        <!--왼쪽 아래 화면 폼-->
            <form action="Insert"name="form" method='post' enctype="multipart/form-data">
                <table>
                    <tr >
                        <td style="width: 375px; padding: 18px">
                                <p style="font-size: 25px; margin: 10px; padding: 8px">Name:&nbsp;
                                    <input type="text" name="itemName" value="Name" style="height: 25px;"></p>

                                <p style="font-size: 25px; margin: 10px; padding: 8px">Url:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <input type="file" name="imageUrl" value="file" style="height: 25px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <input type="file" name="shadowUrl" value="file" style="height: 25px;"></p>

                                <p style="font-size: 25px; margin: 10px; padding: 8px">Cnt:&nbsp;&nbsp;&nbsp;&nbsp;
                                    <select name="itemCnt" style="height: 25px;">
                                        <option value="1">1</option>
                                        <option value="2">2</option>
                                        <option value="3">3</option>
                                        <option value="4">4</option>
                                        <option value="5">5</option>
                                        <option value="6">6</option>
                                        <option value="7">7</option>
                                        <option value="8">8</option>
                                        <option value="9">9</option>
                                        <option value="10">10</option>
                                    </select>
                                </p>
                                위도 <input id="lat" name="lat" type="text" ><br>
                                경도 <input id="lng" name="lng" type="text" >
                        </td>
                        <td valign="top" style="width: 375px;">
                            <p style="font-size: 25px;">Desc:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <textarea name="itemDesc" cols="40" rows="8" ></textarea></p>
                            <input type="submit" value="확인" style="width: 260px; padding: 8px">
                        </td>
                    </tr>
                </table>
                </form>
            </div>
        </td>
        <td valign="top">                                                                                                   <!--오른쪽 화면 리스트-->
            <div  id="box" style="width: 700px; height: 800px; background-color: gray; margin-right: 30px">
                <div style="overflow-y:scroll; height: 100%; margin: 20px;">
                    <a href="" class="item1" > <div style="width: 500px; height: 100px;background-color: darkgray;
                position: relative; display: block; margin: 6%; bottom: auto;"></div></a>
                    </div>
                </div>

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
            center: new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
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
        //var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
        //message += '경도는 ' + latlng.getLng() + ' 입니다';
        var resultDiv = document.getElementById('clickLatlng');
        resultDiv.innerHTML = message;
    });

    //리스트 클릭하면 정보창뜨게하기
</script>
</body>
</html>