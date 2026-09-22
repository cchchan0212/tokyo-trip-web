$root = 'c:\Users\USER\Desktop\VS Code\tokyo-trip-web'
$html = [IO.File]::ReadAllText((Join-Path $root 'index.html'))

$errCatcher = @'
<script>window.__vErr=[];window.addEventListener('error',function(e){window.__vErr.push(String(e.message));});</script>
'@

$runner = @'
<script>
(function () {
    var res = { errors: window.__vErr };
    var bag = String.fromCharCode(0xD83D, 0xDECD);
    try {
      currentDate = '2026-10-07';
      renderTimeline();
      renderQuickLinks();
      var tl = document.getElementById('timeline').innerHTML;
      var ql = document.getElementById('quick-links').innerHTML;
      res.timelineCards = document.querySelectorAll('#timeline > div').length;
      res.times = Array.prototype.map.call(document.querySelectorAll('#timeline span'), function (s) { return s.textContent; }).filter(function (t) { return /^\d\d:\d\d$/.test(t); });
      res.h3Titles = Array.prototype.map.call(document.querySelectorAll('#timeline h3'), function (h) { return h.textContent; });
      res.paraTexts = Array.prototype.map.call(document.querySelectorAll('#timeline p'), function (p) { return p.textContent; });
      res.hasShoppingIcon = tl.indexOf(bag) >= 0;
      res.hasBentoIcon = tl.indexOf(String.fromCharCode(0xD83C, 0xDF71)) >= 0;
      res.detailBtnOnitsuka = tl.indexOf("openSpotDetail('onitsuka_tiger_yaesu')") >= 0;
      res.mapBtnOnitsuka = tl.indexOf("query=Onitsuka+Tiger+NIPPON+MADE") >= 0 || tl.indexOf('Onitsuka+Tiger+NIPPON+MADE') >= 0;
      res.detailBtnUnafuji = tl.indexOf("openSpotDetail('unafuji_yaesu')") >= 0;
      res.quickLinkCount = document.querySelectorAll('#quick-links .quick-link-btn').length;
      res.quickLinkTitles = Array.prototype.map.call(document.querySelectorAll('#quick-links .quick-link-btn'), function (b) { return b.querySelector('.font-bold').textContent; });
      res.quickLinkOnitsuka = ql.indexOf("openSpotDetail('onitsuka_tiger_yaesu')") >= 0;

      openSpotDetail('onitsuka_tiger_yaesu');
      res.modalVisible = !document.getElementById('spot-modal').classList.contains('hidden');
      res.modalIcon = document.getElementById('spot-modal-icon').textContent;
      res.modalIconCodes = document.getElementById('spot-modal-icon').textContent.split('').map(function (c) { return c.charCodeAt(0).toString(16).toUpperCase(); }).join(' ');
      res.modalTitle = document.getElementById('spot-modal-title').textContent;
      res.modalSubtitle = document.getElementById('spot-modal-subtitle').textContent;
      res.modalLabels = Array.prototype.map.call(document.querySelectorAll('#spot-modal-rows dt'), function (d) { return d.textContent; });
      res.modalRows = Array.prototype.map.call(document.querySelectorAll('#spot-modal-rows dd'), function (d) { return d.textContent; });
      res.modalNote = document.getElementById('spot-modal-note').textContent;
      res.modalMapHref = document.getElementById('spot-modal-map').href;
      res.modalMapLabel = document.getElementById('spot-modal-map-label').textContent;
      res.modalSiteDisplay = document.getElementById('spot-modal-site').style.display;
      res.modalButtons = Array.prototype.map.call(document.querySelectorAll('#spot-modal button'), function (b) { return b.textContent.trim(); });
      closeSpotDetail();
      res.closedOk = document.getElementById('spot-modal').classList.contains('hidden');

      openSpotDetail('unafuji_yaesu');
      res.unafujiTitle = document.getElementById('spot-modal-title').textContent;
      res.unafujiRows = document.querySelectorAll('#spot-modal-rows dd').length;
      closeSpotDetail();
    } catch (e) {
      res.exception = String(e && e.stack || e);
    }
    var el = document.createElement('div');
    el.id = 'verify-out';
    el.setAttribute('data-json', btoa(unescape(encodeURIComponent(JSON.stringify(res)))));
    document.body.appendChild(el);
})();
</script>
'@

$html = $html.Replace('<head>', ("<head>`r`n" + $errCatcher))
$html = $html.Replace('</body>', ($runner + "`r`n</body>"))
[IO.File]::WriteAllText((Join-Path $root '_verify3.html'), $html, (New-Object System.Text.UTF8Encoding($false)))
Write-Output 'verify3 page written'
