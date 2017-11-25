<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="kr.dgswhs.berich.bean.*" %>
<%@ page import="java.util.ArrayList" %>
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
                <% if(list != null) {
                	for(int i=0; i < list.size(); i++){
                		DataBean b = list.get(i);
                %>
                 <div style="width: 500px; height: 580px;background-color: darkgray; margin: 6%;">
                        <div style="padding: 3px;"></div>
                            <div id="map2" style="width: 400px;height: 300px ; margin:7%"></div>

                            <textarea name="content" cols="66" rows="7"  style="margin:18px" value = '<%=b.getItemName()%>' readonly></textarea>
                        <p style="font-size: 15px; margin: 3%">Name:<%=b.getItemName()%><input type="text" style="width: 100px;">
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit"  value="삭제하기 "></p>



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
                                position: new daum.maps.LatLng(<%=b.getLat()%>, <%=b.getLng()%>)
                            });

                            // 커스텀 오버레이에 표시할 컨텐츠 입니다
                            // 커스텀 오버레이는 아래와 같이 사용자가 자유롭게 컨텐츠를 구성하고 이벤트를 제어할 수 있기 때문에
                            // 별도의 이벤트 메소드를 제공하지 않습니다
                            var content = '<div class="wrap">' +
                                '    <div class="info">' +
                                '        <div class="title">' +
                                '            카카오 스페이스닷원' +
                                '            <div class="close" onclick="closeOverlay()" title="닫기"></div>' +
                                '        </div>' +
                                '        <div class="body">' +
                                '            <div class="img">' +
                                '                <img src="http://cfile181.uf.daum.net/image/250649365602043421936D" width="73" height="70">' +
                                '           </div>' +
                                '            <div class="desc">' +
                                '                <div class="ellipsis">제주특별자치도 제주시 첨단로 242</div>' +
                                '                <div class="jibun ellipsis">(우) 63309 (지번) 영평동 2181</div>' +
                                '                <div><a href="http://www.kakaocorp.com/main" target="_blank" class="link">홈페이지</a></div>' +
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
                    </div>
                    <%	} // for
                } //if
                %>
                    </div>
                </div>
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