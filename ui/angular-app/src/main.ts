import { bootstrapApplication } from '@angular/platform-browser';
import { Component, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { BridgeService } from './app/core/bridge/bridge.service';

@Component({
  selector: 'ost-root',
  standalone: true,
  imports: [CommonModule],
  template: `
    <main style="padding:16px">
      <h1>Oyana Server Tools</h1>
      <p>Angular UI scaffold is ready.</p>
      <p>Bridge status: {{ bridge.status() }}</p>
      <section>
        <h2>Features</h2>
        <ul>
          <li>Countdown</li>
          <li>Flood</li>
          <li>Map</li>
          <li>Admin</li>
        </ul>
      </section>
    </main>
  `
})
class AppComponent {
  bridge = inject(BridgeService);
}

bootstrapApplication(AppComponent).catch((err) => console.error(err));
