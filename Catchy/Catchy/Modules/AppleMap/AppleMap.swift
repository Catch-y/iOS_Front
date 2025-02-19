//
//  AppleMap.swift
//  Catchy
//
//  Created by 정의찬 on 2/19/25.
//

import MapKit
import SwiftUI

/// 애플 맵 세팅
struct AppleMap: UIViewRepresentable {
    
    @ObservedObject var viewModel: AppleMapViewModel
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.setRegion(viewModel.initialRegion, animated: true)
        mapView.showsUserLocation = true
        
        let camera = MKMapCamera(
            lookingAtCenter: viewModel.initialRegion.center,
            fromDistance: 30000,
            pitch: 30,
            heading: 0
        )
        
        mapView.camera = camera
        
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        mapView.removeAnnotations(mapView.annotations)
        mapView.removeOverlays(mapView.overlays)
        
        let annotations = viewModel.placeInfoData.map { place -> CustomAnnotation in
            let annotation = CustomAnnotation(
                coordinate: place.coordinate,
                title: place.placeName,
                category: place.category,
                isVisited: place.isVisited
            )
            return annotation
        }
        mapView.addAnnotations(annotations)
        
        if let route = viewModel.route {
            mapView.addOverlay(route)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: AppleMap
        
        init(_ parent: AppleMap) {
            self.parent = parent
        }
        
        /// 마커에 커스텀 아이콘 적용
        func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
            guard let annotation = annotation as? CustomAnnotation else { return nil }
            
            let identifier = "CustomMarker"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            
            
            if annotationView == nil {
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
            } else {
                annotationView?.annotation = annotation
            }
            
            let originalImage = annotation.category.mapMarkerImage(isVisited: annotation.isVisited)
            let resizedImage = originalImage.resizeImage(to: CGSize(width: 24, height: 24))
            
            annotationView?.image = resizedImage
            return annotationView
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: any MKOverlay) -> MKOverlayRenderer {
            guard let polyline = overlay as? MKPolyline else { return MKOverlayRenderer() }
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.strokeColor = .m5
            renderer.lineWidth = 3
            renderer.lineCap = .round
            renderer.lineJoin = .round
            
            return renderer
        }
    }
    
    
    
}


class CustomAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var category: CategoryType
    var isVisited: Bool  // 방문 여부 추가

    init(coordinate: CLLocationCoordinate2D, title: String, category: CategoryType, isVisited: Bool) {
        self.coordinate = coordinate
        self.title = title
        self.category = category
        self.isVisited = isVisited
    }
}
