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
            heading: viewModel.userHeading
        )
        
        mapView.camera = camera
        mapView.showsCompass = false
        
        mapView.userTrackingMode = .followWithHeading
        
        let trackingButton = MKUserTrackingButton(mapView: mapView)
        trackingButton.frame = CGRect(x: 20, y: 50, width: 40, height: 40)
        trackingButton.layer.cornerRadius = 8
        trackingButton.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        trackingButton.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        
        mapView.addSubview(trackingButton)
        
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        mapView.removeAnnotations(mapView.annotations)
        mapView.removeOverlays(mapView.overlays)
        
        // 사용자의 현재 위치를 지도 중심으로 설정
        if let userLocation = viewModel.userLocation {
            let camera = MKMapCamera(
                lookingAtCenter: userLocation,
                fromDistance: 30000, // 줌 레벨 조정
                pitch: 45,
                heading: viewModel.userHeading // 사용자의 방향 반영
            )
            mapView.setCamera(camera, animated: true)
        }
        
        // 검색된 장소의 마커를 추가
        let annotations = viewModel.placeInfoData.map { place -> CustomAnnotation in
            let annotation = CustomAnnotation(
                coordinate: place.coordinate,
                title: place.placeName,
                category: place.category,
                isVisited: place.isVisited,
                placeId: place.placeId
            )
            return annotation
        }
        mapView.addAnnotations(annotations)
        
        // 지도 줌 수준에 따라 마커 크기 조정
        let zoomScale = mapView.visibleMapRect.size.width / mapView.bounds.size.width
        let minSize: CGFloat = 32
        let maxSize: CGFloat = 80
        let scaleFactor: CGFloat = 50
        let iconSize = max(minSize, min(maxSize, maxSize / (zoomScale / scaleFactor)))
        
        for annotation in mapView.annotations {
            if let annotationView = mapView.view(for: annotation),
               let customAnnotation = annotation as? CustomAnnotation {
                let originalImage = customAnnotation.category.mapMarkerImage(isVisited: customAnnotation.isVisited)
                let resizedImage = originalImage.resizeImage(to: CGSize(width: iconSize, height: iconSize))
                annotationView.image = resizedImage
            }
        }
        
        // 4️⃣ 검색된 경로 추가
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
        
        //MARK: - Annotation
        
        func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
            guard let customAnnotation = annotation as? CustomAnnotation else { return }
            
            DispatchQueue.main.async {
                if self.parent.viewModel.selectedPlaceId == customAnnotation.placeId {
                    self.parent.viewModel.selectedPlaceId = nil
                } else {
                    self.parent.viewModel.selectedPlaceId = customAnnotation.placeId
                }
            }
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard let annotation = annotation as? CustomAnnotation else { return nil }
            
            let identifier = "CustomMarker"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            
            if annotationView == nil {
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
            } else {
                annotationView?.annotation = annotation
            }
            
            let zoomScale = mapView.visibleMapRect.size.width / mapView.bounds.size.width
            
            let minSize: CGFloat = 32
            let maxSize: CGFloat = 80
            let scaleFactor: CGFloat = 50
            
            let iconSize = max(minSize, min(maxSize, maxSize / (zoomScale / scaleFactor)))
            
            let originalImage = annotation.category.mapMarkerImage(isVisited: annotation.isVisited)
            let resizedImage = originalImage.resizeImage(to: CGSize(width: iconSize, height: iconSize))
            
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
        
        //지도 줌 레벨 변경 감지 및 annotation 크기 업데이트
        func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
            let zoomScale = mapView.visibleMapRect.size.width / mapView.bounds.size.width
            
            let minSize: CGFloat = 32
            let maxSize: CGFloat = 80
            let scaleFactor: CGFloat = 50
            
            let iconSize = max(minSize, min(maxSize, maxSize / (zoomScale / scaleFactor)))
            
            for annotation in mapView.annotations {
                if let annotationView = mapView.view(for: annotation),
                   let customAnnotation = annotation as? CustomAnnotation {
                    let originalImage = customAnnotation.category.mapMarkerImage(isVisited: customAnnotation.isVisited)
                    let resizedImage = originalImage.resizeImage(to: CGSize(width: iconSize, height: iconSize))
                    annotationView.image = resizedImage
                }
            }
        }
    }
}

class CustomAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var category: CategoryType
    var isVisited: Bool
    var placeId: Int
    
    init(coordinate: CLLocationCoordinate2D, title: String, category: CategoryType, isVisited: Bool, placeId: Int) {
        self.coordinate = coordinate
        self.title = title
        self.category = category
        self.isVisited = isVisited
        self.placeId = placeId
    }
}
