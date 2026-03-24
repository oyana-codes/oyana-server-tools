(function () {
  const root = document.getElementById('app');
  if (root) {
    root.innerHTML = '<p>UI bridge ready.</p>';
  }
  window.OST_UI = {
    dispatch(eventName, payload) {
      console.log('[OST_UI]', eventName, payload);
    }
  };
})();
