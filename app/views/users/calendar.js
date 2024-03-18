document.addEventListener('turbolinks:load', function() {
  var calendarEl = document.getElementById('calendar');
  var calendar = new Calendar(calendarEl, {
    plugins: [ dayGridPlugin, interactionPlugin ],
    locale: 'ja',
    buttonText: {
        prev:     '<',
        next:     '>',
        prevYear: '<<',
        nextYear: '>>',
        today:    '今日',
        month:    'カレンダー',
        week:     '週',
        day:      '日',
        listMonth: '今月のToDo',
        listDay: '今日のToDo'
    },

    headerToolbar: {
        left: 'prev,next',
        center: 'title',
        right: 'dayGridMonth,listMonth,listDay',
    },
    navLinks: true,
    selectable: true,
    select: function (info) {
      const eventName = prompt("イベントを入力してください");
      if (eventName) {
        var xhr = new XMLHttpRequest();
        xhr.open('POST', '/events', true);
        xhr.setRequestHeader('Content-Type', 'application/json');
        xhr.onreadystatechange = function() {
          if (xhr.readyState === XMLHttpRequest.DONE) {
            if (xhr.status === 200) {
              var response = JSON.parse(xhr.responseText);
              // サーバーからのレスポンスを処理
              calendar.addEvent({
                  title: eventName,
                  start: info.start,
                  end: info.end,
                  allDay: true,
              });
            } else {
              // エラーハンドリング
              console.log('エラーが発生しました');
            }
          }
        };
        addCsrfToken(xhr); // CSRFトークンをリクエストヘッダに追加
        var data = JSON.stringify({
          title: eventName,
          start_time: info.start,
          end_time: info.end,
        });
        xhr.send(data);
      }
    },
  });
  calendar.render();
});