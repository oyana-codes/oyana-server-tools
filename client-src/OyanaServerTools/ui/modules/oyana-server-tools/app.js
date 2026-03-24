(function () {
  const featureList = document.getElementById('feature-list');
  const countdown = document.getElementById('countdown');
  const countdownLabel = document.getElementById('countdown-label');
  const countdownValue = document.getElementById('countdown-value');
  const countdownStatus = document.getElementById('countdown-status');
  const readyFeatures = new Set();

  function renderReadyFeatures() {
    const features = [...readyFeatures].sort();
    featureList.textContent = features.length
      ? `Ready: ${features.join(', ')}`
      : 'Waiting for features...';
  }

  function renderCountdown(payload) {
    countdown.classList.remove('hidden');
    countdownLabel.textContent = payload.label || 'Countdown';

    if (payload.completed) {
      countdownValue.textContent = 'GO';
      countdownStatus.textContent = 'Countdown complete';
      return;
    }

    countdownValue.textContent = String(payload.secondsLeft ?? '');
    countdownStatus.textContent = payload.active
      ? 'Countdown active'
      : 'Countdown stopped';

    if (!payload.active && Number(payload.secondsLeft || 0) <= 0) {
      setTimeout(() => countdown.classList.add('hidden'), 1200);
    }
  }

  renderReadyFeatures();

  window.OST_UI = {
    dispatch(eventName, payload) {
      console.log('[OST_UI]', eventName, payload);

      if (eventName === 'OST:UI:FeatureReady') {
        readyFeatures.add(String(payload));
        renderReadyFeatures();
        return;
      }

      if (eventName === 'OST:UI:CountdownState') {
        renderCountdown(payload || {});
      }
    }
  };
})();
