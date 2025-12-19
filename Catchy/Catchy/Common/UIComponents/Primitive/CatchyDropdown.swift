//
//  CatchyDropdown.swift
//  Catchy
//
//  Created by euijjang97 on 12/19/25.
//

import SwiftUI

struct CatchyDropdown: View {
    // MARK: - Property
    @State private var isExpand: Bool = false
    @Binding var selectedValue: String?
    let headerText: String
    let values: [String]
    
    // MARK: - Constant
    fileprivate enum DropdownConstants {
        static let dropdownHeaderPadding: EdgeInsets = .init(top: 12, leading: 17, bottom: 12, trailing: 17)
        static let dropListPadding: EdgeInsets = .init(top: 11, leading: 5, bottom: 11, trailing: 5)
        static let mainVspacing: CGFloat = 7
        static let cornerRadius: CGFloat = 12
        static let chevronImage: String = "chevron.up"
        static let checkMark: String = "checkmark"
    }
    
    // MARK: - Init
    init(selectedValue: Binding<String?>, headerText: String, values: [String]) {
        self._selectedValue = selectedValue
        self.headerText = headerText
        self.values = values
    }
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: DropdownConstants.mainVspacing, content: {
            dropdownHeader
            
            if isExpand {
                dropdownList
                    .zIndex(1)
            }
        })
    }
}

// MARK: - SubViews
extension CatchyDropdown {
    private var dropdownHeader: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: DefaultConstants.animationTime)) {
                isExpand.toggle()
            }
        }, label: {
            headerContent
        })
        .buttonStyle(.glass)
    }
    
    private var headerContent: some View {
        HStack {
            Text(selectedValue ?? headerText)
                .font(.body2)
                .foregroundStyle(selectedValue == nil ? .g5 : .black)
            
            Spacer()
            
            Image(systemName: DropdownConstants.chevronImage)
                .rotationEffect(.degrees(isExpand ? 0 : 180))
                .foregroundStyle(.g5)
                .animation(.easeInOut(duration: DefaultConstants.animationTime), value: isExpand)
        }
        .padding(DropdownConstants.dropdownHeaderPadding)
        .accessibilityLabel(selectedValue ?? headerText)
        .accessibilityHint("선택하려면 탭하세요")
        .accessibilityAddTraits(isExpand ? [.isSelected] : [])
    }
    
    private var dropdownList: some View {
        LazyVStack(spacing: .zero, content: {
            ForEach(values, id: \.self) { value in
                Button(action: {
                    withAnimation(.easeInOut(duration: DefaultConstants.animationTime)) {
                        selectedValue = value
                        isExpand = false
                    }
                }, label: {
                    dropdownContent(value)
                })
                .accessibilityLabel(value)
                .accessibilityAddTraits(selectedValue == value ? [.isSelected] : [])
            }
        })
        .padding(DropdownConstants.dropListPadding)
        .glassEffect(.regular.interactive(), in: RoundedRectangle(cornerRadius: DropdownConstants.cornerRadius))
    }
    
    private func dropdownContent(_ text: String) -> some View {
        HStack {
            Text(text)
                .font(.body2)
                .foregroundStyle(selectedValue == text ? .main : .black)
            Spacer()
            if selectedValue == text {
                Image(.check)
                    .foregroundStyle(.main)
                    .transition(.scale.combined(with: .opacity))
            }
        }
        .padding(DropdownConstants.dropdownHeaderPadding)
        .background(selectedValue == text ? .m1 : .clear)
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var selectedDate: String?
        
        let values = [
            "2024년 1월 15일",
            "2024년 2월 20일",
            "2024년 3월 25일",
            "2024년 4월 30일"
        ]
        
        var body: some View {
            VStack(spacing: 20) {
                Text("선택된 날짜: \(selectedDate ?? "없음")")
                    .font(.headline)
                
                CatchyDropdown(
                    selectedValue: $selectedDate,
                    headerText: "안녕",
                    values: values
                )
                .padding()
                
                Spacer()
            }
            .padding()
        }
    }
    
    return PreviewWrapper()
}
