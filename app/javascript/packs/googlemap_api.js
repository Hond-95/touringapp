let map
let geocoder
let marker
let infoWindow

window.initMap = function(){
  map = new google.maps.Map(document.getElementById('map'), {
  center: {lat: 35.68123620000001, lng:139.7671248},
  zoom: 13
  });
}

window.codeAddress = function(){
  // 入力を取得
  map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: 35.68123620000001, lng:139.7671248},
    zoom: 13
  });

  let inputAddress = document.getElementById('address').value;

  geocoder = new google.maps.Geocoder();

  // 入力フォームに入力がある場合のみ
  if (inputAddress !== null && inputAddress !== '') {
    // geocodingしたあとmapを移動
    geocoder.geocode( { 'address': inputAddress}, function(results, status) {
      if (status == 'OK') {
        // 既にあるマーカーを削除
          deleteMakers();

        // map.setCenterで地図が移動
        map.setCenter(results[0].geometry.location);

        // google.maps.MarkerでGoogleMap上の指定位置にマーカが立つ
        marker = new google.maps.Marker({
            map: map,
            position: results[0].geometry.location
        });

        var position = results[0].geometry.location;
        var address = results[0].formatted_address;
        // マーカーへの吹き出しの追加
        setInfoW(inputAddress, position, address);
        // マーカーにクリックイベントを追加
        markerEvent();

        infoWindow.open(map, marker);

      } else if (status == google.maps.GeocoderStatus.ZERO_RESULTS) {
        alert("見つかりません");

      } else {
        console.log(status);
        alert("エラー発生");
      }
    });
  }
}

//マーカーを削除する
function deleteMakers() {
  if(marker != null){
    marker.setMap(null);
  }
  marker = null;
}

// マーカーへの吹き出しの追加
function setInfoW(inputAddress, position, address) {
  infoWindow = new google.maps.InfoWindow({
  content: "<a href='http://www.google.com/search?q=" + inputAddress + "' target='_blank'>" + inputAddress + "</a><br><br>" + position + "<br><br>" + address + "<br><br><a href='http://www.google.com/search?q=" + inputAddress + "&tbm=isch' target='_blank'>画像検索 by google</a>"
});
}

// クリックイベント
function markerEvent() {
marker.addListener('click', function() {
  infoWindow.open(map, marker);
});
}
