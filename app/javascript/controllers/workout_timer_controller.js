import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["display", "startButton"];

  connect() {
    this.audioUnlocked = false;
    this.intervalId = null;
    this.started = false;
    this.startSoundUrl = this.element.dataset.countdownStartUrl;
    this.doneSoundUrl = this.element.dataset.timerDoneUrl;

    this.boundUnlockAudio = this.unlockAudio.bind(this);
    this.element.addEventListener("click", this.boundUnlockAudio, {
      once: true,
      passive: true,
    });
    this.startButtonTarget?.setAttribute("aria-disabled", "false");
  }

  disconnect() {
    if (this.intervalId) window.clearInterval(this.intervalId);
    this.element.removeEventListener("click", this.boundUnlockAudio);
  }

  unlockAudio() {
    if (this.audioUnlocked) return;

    this.audioUnlocked = true;
    this.startAudio = new Audio(this.startSoundUrl);
    this.doneAudio = new Audio(this.doneSoundUrl);
    this.startAudio.load();
    this.doneAudio.load();
  }

  startTimer() {
    if (this.started) return;

    this.started = true;
    this.startButtonTarget?.setAttribute("aria-disabled", "true");
    this.startButtonTarget?.setAttribute("disabled", "disabled");
    this.startButtonTarget.textContent = "Starting...";

    const duration = Number.parseInt(this.element.dataset.duration || "0", 10);
    const prepSeconds = 5;
    let elapsed = 0;
    let remaining = duration;
    let countdownStarted = false;

    this.displayTarget.textContent = `Starting in ${prepSeconds}s`;

    this.intervalId = window.setInterval(() => {
      elapsed += 1;

      if (elapsed <= prepSeconds) {
        const remainingPrep = prepSeconds - elapsed + 1;
        this.displayTarget.textContent = `Starting in ${remainingPrep}s`;
        return;
      }

      if (!countdownStarted) {
        countdownStarted = true;
        this.playSound(this.startAudio);
      }

      if (remaining <= 0) {
        window.clearInterval(this.intervalId);
        this.playSound(this.doneAudio);
        this.displayTarget.textContent = "0:00";
        return;
      }

      this.displayTarget.textContent = `${Math.floor(remaining / 60)}:${(remaining % 60).toString().padStart(2, "0")}`;
      remaining -= 1;
    }, 1000);
  }

  playSound(audioObject) {
    if (!this.audioUnlocked || !audioObject) {
      return;
    }

    audioObject.currentTime = 0;
    audioObject.play().catch(() => {});
  }
}
