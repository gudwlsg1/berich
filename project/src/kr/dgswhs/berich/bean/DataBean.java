package kr.dgswhs.berich.bean;
public class DataBean{
	
	private int itemId; // ���������� ��ȣ
	private int itemCnt; // ���������� ����
	private String itemName; // �����������̸�
	private String itemDesc; //������ ���� 
	private String imageUrl; // �̹���
	private String shadowUrl;// �׸��� �̹���
	private double lat; //���� 
	private double lng; //�浵
	public int getItemId() {
		return itemId;
	}
	public void setItemId(int itemId) {
		this.itemId = itemId;
	}
	public int getItemCnt() {
		return itemCnt;
	}
	public void setItemCnt(int itemCnt) {
		this.itemCnt = itemCnt;
	}
	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	public String getItemDesc() {
		return itemDesc;
	}
	public void setItemDesc(String itemDesc) {
		this.itemDesc = itemDesc;
	}
	public String getImageUrl() {
		return imageUrl;
	}
	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
	public String getShadowUrl() {
		return shadowUrl;
	}
	public void setShadowUrl(String shadowUrl) {
		this.shadowUrl = shadowUrl;
	}
	public double getLat() {
		return lat;
	}
	public void setLat(double lat) {
		this.lat = lat;
	}
	public double getLng() {
		return lng;
	}
	public void setLng(double lng) {
		this.lng = lng;
	}

	
}
