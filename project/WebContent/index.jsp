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

<body>
<%
	String message = request.getParameter("message");
	if(message != null){
		if(message.equals("s"))
			out.println("저장 완료");
		else
			out.println("저장 실패");
	}
	ArrayList<DataBean> list = DBBean.getInstance().select(-1);
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
                <table>
                    <tr>
                        <h2 style="padding: 20px;  ">Make treasure</h2>
                        <td style="width: 375px; padding: 10px;">

                                <form class="form-inline" style="padding:10px;">
                                    <div class="form-group">
                                        <label for="name">Name:</label>
                                        <input type="text" class="form-control" id="name" placeholder="Enter name" name="name">
                                    </div>
                                    <div class="form-group" style="margin: 20px 0px">
                                        <label for="count">Count:</label>
                                        <select class="form-control" id="count">
                                        <option>1</option>
                                        <option>2</option>
                                        <option>3</option>
                                        <option>4</option>
                                        <option>5</option>
                                        <option>6</option>
                                        <option>7</option>
                                        <option>8</option>
                                        <option>9</option>
                                        <option>10</option>
                                        </select>
                                    </div>
                                    <form method="POST" action="#" enctype="multipart/form-data">
                                        <div class="input-group">
                                            <div class="input-group">
                                                <label>Image File:</label>
                                            </div>
                                            <div class="input-group">
                                                <input type="text" id="filename" class="form-control" readonly required aria-label="Selected file name">
                                                <span class="input-group-btn">
                                                    <button class="btn btn-secondary" type="button" id="browsebutton">Browse</button>
                                                </span>
                                            </div>
                                            <input class="form-control file" type="file" id="fileinput" name="imageUrl" required aria-label="Hidden input for file selection">
                                        </div>
                                        <div class="input-group">
                                            <div class="input-group">
                                                <label>Shadow Image File:</label>
                                            </div>
                                            <div class="input-group">
                                                <input type="text" id="filename2" class="form-control" readonly required aria-label="Selected file name">
                                                <span class="input-group-btn">
                                                    <button class="btn btn-secondary" type="button" id="browsebutton2">Browse</button>
                                                </span>
                                            </div>
                                            <input class="form-control file" type="file" id="fileinput2" name="shadowUrl" required aria-label="Hidden input for file selection">
                                        </div>
                                    </form>
                                    <button type="submit" class="btn btn-default" style="margin: 10px">Submit</button>
                                </form>

                                <input id="lat" name="lat" type="hidden" style="border-radius: 30px;"><br>
                                <input id="lng" name="lng" type="hidden"  style="border-radius: 30px;">

                        </td>
                        <td valign="top" style="width: 300px; padding: 8px">
                            <label>Info:</label>
                                <textarea rows="6" cols="8" class="form-control"></textarea>
                        </td>
                    </tr>
                </table>
            </div>

        </td>
        <td valign="top">                                                                                                   <!--오른쪽 화면 리스트-->
            <div  id="box" style="width: 700px; height: 745px; background-color: gray; margin-right: 30px">
                <div style="overflow-y:scroll; height: 100%; margin: 20px;">
				<% if(list != null) {
                	for(int i=0; i < list.size(); i++){
                		DataBean b = list.get(i);
                		String itemName = b.getItemName();
                		String imageUrl = b.getImageUrl();
                		String itemDesc = b.getItemDesc();
                %>
                    <div style="width: 500px; height: 580px;background-color: darkgray; margin: 6%;">
                        <div style="padding: 3px;"></div>
                            <div id="map2" style="width: 400px;height: 300px ; margin:7%"></div>

                        <textarea class="form-control" rows="5" cols="5" value = '<%=itemDesc%>' readonly></textarea>
                        <div class="form-group">
                        <label for="name">Name:</label>
                        <input type="text" class="form-control" id="name" placeholder="Enter name" name="name" style="width: 180px" value = '<%=itemName%>'>
                    </div>



                        <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c59727be163045e7f3830a65c8a89d9e"></script>
                        <script>
                            var mapContainer = document.getElementById('map2'), // 지도의 중심좌표
                                mapOption = {
                                    center: new daum.maps.LatLng(33.451475, 126.570528), // 지도의 중심좌표
                                    draggable : false,
                                    level: 3 // 지도의 확대 레벨
                                };

                            var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

                            // 지도에 마커를 표시합니다
                            var marker = new daum.maps.Marker({
                                map: map,
                                position: new daum.maps.LatLng(33.450701, 126.570667)
                            });

                            // 커스텀 오버레이에 표시할 컨텐츠 입니다
                            // 커스텀 오버레이는 아래와 같이 사용자가 자유롭게 컨텐츠를 구성하고 이벤트를 제어할 수 있기 때문에
                            // 별도의 이벤트 메소드를 제공하지 않습니다
                            var content = '<div class="wrap">' +
                                '    <div class="info">' +
                                '        <div class="title">' +
                                '	<%=itemName%>' +
                                '            <div class="close" onclick="closeOverlay()" title="닫기"></div>' +
                                '        </div>' +
                                '        <div class="body">' +
                                '            <div class="img">' +
                                '                <img src="<%=imageUrl%>" width="73" height="70">' +
                                '           </div>'+
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
                    </div>
                    </div>
                </div>
				<%	} // for
                } //if
                %>
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
        var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
        message += '경도는 ' + latlng.getLng() + ' 입니다';
        var resultDiv = document.getElementById('clickLatlng');
        resultDiv.innerHTML = message;
    });
</script>
</body>
</html>