<br>
<img width="305" height="472" alt="Screenshot 2026-01-11 at 06 43 51" src="https://github.com/user-attachments/assets/61f3ef89-fc28-4d8e-8973-1d49ddeddf4d" />
<img width="315" height="474" alt="Screenshot 2026-01-11 at 06 44 08" src="https://github.com/user-attachments/assets/203a84b9-4c2e-4bcc-a03e-6e3d7a48e8fa" />



<br>
<br>


# 🏛️ Advanced Modular iOS Architecture

![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)
![Platform](https://img.shields.io/badge/Platform-iOS-lightgrey.svg)
![License](https://img.shields.io/badge/License-MIT-blue.svg)
![Architecture](https://img.shields.io/badge/Architecture-MVVM%20%2B%20DI%20%2B%20Router-green.svg)

## ✍️ Mimari İmza ve Referans

Bu proje; **[Yusuf Çınar](https://medium.com/@cinaryusuf)** tarafından tasarlanan ve makalelerinde detaylandırılan modern iOS mimari yaklaşımları (Architecture Signature) birebir uygulanarak hayata geçirilmiştir.

Yusuf Çınar'ın kurumsal ölçekli projeler için geliştirdiği **"Modular Label Design"**, **"Service Locator & DI"** ve **"Router Pattern"** konseptleri bu projenin temelini oluşturur.

---

## 🎯 Projenin Amacı

Kurumsal ölçekli, büyük takımlarla geliştirilen iOS uygulamalarında karşılaşılan **Tight Coupling (Sıkı Bağımlılık)**, **Tekrar Eden Kod (Code Duplication)** ve **Test Edilebilirlik** sorunlarını çözmek amacıyla geliştirilmiş ileri seviye bir mimari şablonudur.

**UIKit (Programmatic UI)** ve **SnapKit** kullanılarak, Clean Code prensiplerine sadık kalınarak inşa edilmiştir.

---

## 🏗️ Mimari ve Akış Diyagramları

Proje, **Separation of Concerns (İlgi Alanlarının Ayrımı)** prensibi üzerine kurulmuştur. Veri, İş Mantığı ve Arayüz birbirinden tamamen izole edilmiştir.

### 1. Genel Veri Akışı (MVVM & Router)

Aşağıdaki diyagram, bir kullanıcının butona bastığı andan itibaren arka planda çalışan akışı özetler:

```mermaid
sequenceDiagram
    participant User as Kullanıcı
    participant VC as View Controller
    participant VM as ViewModel
    participant SL as @Inject (Service Locator)
    participant Router as Router

    User->>VC: Butona Tıklar (Giriş Yap)
    VC->>VC: UI Validasyonu (Strategy Pattern)
    alt Validasyon Başarılı
        VC->>VM: login(email: String)
        VM->>SL: Servis İsteği (@Inject)
        SL-->>VM: SessionService Instance
        VM->>VM: İş Mantığını Çalıştır (Kaydet)
        VM-->>VC: Başarılı Callback (Closure)
        VC->>Router: navigate(to: HomeVC)
        Router-->>VC: Yeni Sayfayı Push Et
    else Validasyon Hatalı
        VC-->>User: Hata Mesajı Göster
    end

```

### 2. Dependency Injection (Bağımlılık Yönetimi)

Servislerin sınıflar içine `new Class()` diyerek gömülmesi yerine, merkezi bir dağıtıcıdan istenmesi prensibidir.

```mermaid
graph TD
    A[ViewController / ViewModel] -->|Talep Eder| B(Property Wrapper @Inject)
    B -->|Sorgular| C{Service Locator}
    C -->|Varsa Getir| D[Registry Cache]
    C -->|Yoksa Oluştur| E[Service Factory]
    E -->|Kaydet| D
    D -->|Servisi Dön| B
    B -->|Inject Et| A

```

---

## 🚀 Kullanılan Teknolojiler ve Desenler

Bu proje, "Spagetti Kod" oluşumunu engellemek için aşağıdaki tasarım desenlerini (Design Patterns) uygular:

### 1. MVVM (Model-View-ViewModel)

* **Amaç:** UI (View Controller) ile İş Mantığını (ViewModel) ayırmak.
* **Uygulama:** `BaseVC<T>` generic yapısı sayesinde her View Controller, kendi ViewModel'ini otomatik olarak oluşturur.

### 2. Dependency Injection & Service Locator

* **Amaç:** Sınıfların birbirine sıkı sıkıya bağlanmasını engellemek.
* **Uygulama:** `ServiceLocator` sınıfı tüm servisleri (Auth, Network, Storage) tutar. `@Inject` property wrapper'ı ise bu servisleri tek satırda çağırmamızı sağlar.

### 3. Router Pattern (Navigation)

* **Amaç:** Bir ekranın, gideceği diğer ekranı tanımasını engellemek (Loose Coupling).
* **Uygulama:** `navigationController.push(...)` kodları View Controller'dan çıkarılıp, merkezi `Router.shared.navigate(...)` yapısına taşınmıştır.

### 4. Strategy Pattern (UI Components)

* **Amaç:** UI elemanlarının davranışlarını modüler hale getirmek.
* **Uygulama:**
* **Labels:** `LabelStyleProvider` protokolü ile Header, Body gibi stiller dinamik olarak uygulanır.
* **Validation:** `EmailValidator`, `PasswordValidator` gibi kurallar `ValidationProvider` üzerinden `FormField` bileşenine enjekte edilir.



### 5. Property Wrappers (Storage)

* **Amaç:** UserDefaults ve Keychain gibi veri saklama işlemlerindeki kod kirliliğini önlemek.
* **Uygulama:** `@UserDefaultsStorage(key: "token")` etiketi ile veriler otomatik kaydedilir/okunur.

---

## 📂 Klasör Yapısı

Proje, modülerliği destekleyen bir klasör yapısına sahiptir:

```text
ModularArchitectureApp
├── Core                 # Uygulamanın Beyni (İş mantığından bağımsız altyapı)
│   ├── DI               # Service Locator ve Inject Wrapper
│   ├── Storage          # UserDefaults ve Keychain Yöneticileri
│   └── Router           # Navigasyon Yöneticisi
├── UIComponents         # Tekrar Kullanılabilir Görsel Bileşenler
│   ├── Labels           # Strateji deseni ile stillendirilmiş Label'lar
│   └── FormFields       # Validasyon yeteneği olan Input alanları
├── Scenes               # Uygulama Ekranları
│   ├── Base             # BaseVC ve BaseVM (Generic altyapı)
│   └── Login            # Örnek Login Modülü (VC ve VM)
└── App                  # AppDelegate ve SceneDelegate (Composition Root)

```

---

<br>


## 📝 Nasıl Kullanılır?

### Yeni Bir Servis Eklemek

```swift
// 1. Protokolü tanımla
protocol NetworkServiceProtocol { ... }

// 2. SceneDelegate içinde kaydet
ServiceLocator.shared.register(NetworkService() as NetworkServiceProtocol)

// 3. İstediğin yerde kullan
@Inject var networkService: NetworkServiceProtocol

```

### Yeni Bir Ekran Eklemek

```swift
// 1. ViewModel oluştur
class HomeVM: BaseVM { ... }

// 2. ViewController oluştur (Generic yapı otomatik bağlar)
class HomeVC: BaseVC<HomeVM> { ... }

```

---

## 📚 Kaynaklar ve Teşekkür

Bu projenin mimari altyapısı, **[Yusuf Çınar](https://www.google.com/url?sa=E&source=gmail&q=https://medium.com/@cinaryusuf)** tarafından yazılan aşağıdaki makaleler temel alınarak oluşturulmuştur:

* [Swift ile Modüler UILabel Tasarımı](https://www.google.com/url?sa=E&source=gmail&q=https://medium.com/@cinaryusuf)
* [Dependency Injection ve Service Locator Deseni](https://www.google.com/url?sa=E&source=gmail&q=https://medium.com/@cinaryusuf)
* [iOS Uygulamalarında Router ve Veri Transferi Yönetimi](https://www.google.com/url?sa=E&source=gmail&q=https://medium.com/@cinaryusuf)
* [Swift ile Property Wrapper Kullanarak Storage Yapısı](https://www.google.com/url?sa=E&source=gmail&q=https://medium.com/@cinaryusuf)

---

**Uygulayan Geliştirici: Uğur Hamzaoğlu**


