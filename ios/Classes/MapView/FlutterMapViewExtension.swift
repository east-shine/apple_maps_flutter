extension FlutterMapView {
    /// Releases all resources associated with the map view.
    func dispose() {
        // Stop location updates and release CLLocationManager resources
        locationManager.stopUpdatingLocation()
        locationManager.delegate = nil
        
        // Remove all annotations, overlays, and gesture recognizers
        self.removeAnnotations(self.annotations)
        self.removeOverlays(self.overlays)
        self.gestureRecognizers?.forEach { self.removeGestureRecognizer($0) }
        
        // Reset delegates to prevent potential memory leaks
        self.delegate = nil
        self.mapContainerView = nil
        self.channel = nil
        
        // Release additional resources if required
        self.removeFromSuperview()
    }
}
