// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//= require jquery
import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application";

Rails.start();
Turbolinks.start();
ActiveStorage.start();
require("jquery");
import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import interactionPlugin from '@fullcalendar/interaction';
var csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');

// AjaxリクエストにCSRFトークンを含める関数
function addCsrfToken(xhr) {
  xhr.setRequestHeader('X-CSRF-Token', csrfToken);
}

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
          start: info.start,
          end: info.end,
        });
        xhr.send(data);
      }
    },
    editable: true,
      dayMaxEvents: true, // allow "more" link when too many events
      // 情報の取得(json経由)
      events: '/events.json',







  });
  calendar.render();
});
