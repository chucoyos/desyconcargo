// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

// Toast notifications
document.addEventListener("turbo:load", function() {
  setupToastAutoHide();
  setupToastObserver();
});

document.addEventListener("turbo:frame-load", function() {
  setupToastAutoHide();
});

// Function to setup auto-hide for all current toasts
function setupToastAutoHide() {
  const toasts = document.querySelectorAll('.toast:not(.toast-auto-hide-setup)');
  
  toasts.forEach(function(toast) {
    // Mark this toast as having auto-hide setup
    toast.classList.add('toast-auto-hide-setup');
    
    // Auto-hide after 5 seconds
    setTimeout(function() {
      hideToast(toast);
    }, 5000);
  });
}

// Function to setup observer for dynamically added toasts
function setupToastObserver() {
  const toastContainer = document.getElementById('toast-container');
  if (!toastContainer) return;
  
  const observer = new MutationObserver(function(mutations) {
    mutations.forEach(function(mutation) {
      mutation.addedNodes.forEach(function(node) {
        if (node.nodeType === Node.ELEMENT_NODE && node.classList.contains('toast')) {
          // New toast added, setup auto-hide
          node.classList.add('toast-auto-hide-setup');
          setTimeout(function() {
            hideToast(node);
          }, 5000);
        }
      });
    });
  });
  
  observer.observe(toastContainer, { childList: true });
}

// Function to hide a toast with animation
function hideToast(toast) {
  toast.style.transform = 'translateX(100%)';
  setTimeout(function() {
    toast.remove();
  }, 300);
}

// Handle toast close buttons
document.addEventListener('click', function(event) {
  if (event.target.closest('.toast-close')) {
    const toast = event.target.closest('.toast');
    hideToast(toast);
  }
});
